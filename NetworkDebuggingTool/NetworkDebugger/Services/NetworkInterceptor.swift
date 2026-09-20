import Foundation

class NetworkInterceptor: URLProtocol {
    
    private static let handledKey = "NetworkInterceptorHandled"
    
    private lazy var session: URLSession =  URLSession(configuration: .ephemeral)
    private var dataTask: Task<Void, Never>?
    
    override class func canInit(with request: URLRequest) -> Bool {
        if URLProtocol.property(forKey: Self.handledKey, in: request) != nil {
            // don't re-handle the request we ourselves forward
            return false
        }
        
        guard let scheme = request.url?.scheme?.lowercased() else {
            return false
        }
        
        return scheme == "https" || scheme == "http"
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        let start = Date()
        
        if let mockData = activeMock(for: request) {
            serverMock(for: request, mock: mockData, start: start)
            return
        }
        
        guard let mutableRequest = (request as NSURLRequest).mutableCopy() as? NSMutableURLRequest else {
            fatalError("[NetworkInterceptor][startLoading]: Could not make mutable request")
        }
        
        URLProtocol.setProperty(true, forKey: Self.handledKey, in:mutableRequest)
        
        dataTask = Task { [weak self] in
            guard let self else { return }
            
            do {
                let (data, response) = try await self.session.data(for: mutableRequest as URLRequest)

                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                self.client?.urlProtocol(self, didLoad: data)
                self.client?.urlProtocolDidFinishLoading(self)
                
                let networkCall = NetworkCall(
                    request: request,
                    response: response as? HTTPURLResponse,
                    data: data,
                    error: nil,
                    startTime: start,
                    endTime: Date())
                
                NetworkCallStore.shared.add(networkCall)
                
            } catch {
                self.client?.urlProtocol(self, didFailWithError: error)
                let networkCall = NetworkCall(request: request, response: nil, data: nil, error: error, startTime: start, endTime: Date())
                NetworkCallStore.shared.add(networkCall)
            }
            
            
        }
    }
    
    override func stopLoading() {
        dataTask?.cancel()
        dataTask = nil
    }
    
    private func activeMock(for request: URLRequest) -> Mock? {
        guard let url = request.url?.absoluteString,
              let method = request.httpMethod else {
            return nil
        }
        
        return MockStore.enabledSnapshot.first { mock in
            url.contains(mock.urlPattern) && mock.httpMethod == method
        }
    }
    
    private func serverMock(for request: URLRequest, mock: Mock, start: Date) {
        guard let fileURL = Bundle.main.url(forResource: mock.jsonFileName, withExtension: nil)
                ?? Bundle.main.url(forResource: mock.jsonFileName.replacingOccurrences(of: ".json", with: ""), withExtension: "json"),
              let data = try? Data(contentsOf: fileURL) else {
            let error = NSError(domain: "NetworkDebugger",
                                code: 404,
                                userInfo: [NSLocalizedDescriptionKey: "Mock file '\(mock.jsonFileName)' not found in bundle."])
            
            client?.urlProtocol(self, didFailWithError: error)
            Task {
                let networkCall = NetworkCall(request: request, response: nil, data: nil, error: error, startTime: start, endTime: Date())
                NetworkCallStore.shared.add(networkCall)
            }
            
            return
        }
        
        let response = HTTPURLResponse(url: request.url!,
                                       statusCode: 200,
                                       httpVersion: "HTTP/1.1",
                                       headerFields: nil)!
        
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: data)
        client?.urlProtocolDidFinishLoading(self)
        
        Task {
            let networkCall = NetworkCall(
                request: request,
                response: response,
                data: data,
                error: nil,
                startTime: start,
                endTime: Date())
            
            NetworkCallStore.shared.add(networkCall)
        }
    }
    
}
