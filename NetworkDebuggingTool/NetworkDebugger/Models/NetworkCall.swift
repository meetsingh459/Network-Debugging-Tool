
import Foundation

struct NetworkCall: Identifiable {
    let id = UUID()
    let request: URLRequest
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?
    let startTime: Date
    let endTime: Date
    
    var method: String { request.httpMethod ?? "GET" }
    var path: String { request.url?.absoluteString ?? "__unknown_url__" }
    var host: String? { request.url?.host ?? "" }
    var statusCode: Int? { response?.statusCode }
    var duration: Int { Int(endTime.timeIntervalSince(startTime) * 1000) }
    
    var responseHeaderText: String {
        guard let response else { return "No Response" }
        var lines = ["Status: \(response.statusCode)"]
        for (key, value) in response.allHeaderFields {
            lines.append("\(key): \(value)")
        }
        return lines.joined(separator: "\n")
    }

    var responseBody: String {
        guard let data, !data.isEmpty else { return "No response body" }
        if let object = try? JSONSerialization.jsonObject(with: data),
           let pretty = try? JSONSerialization.data(withJSONObject: object,
                                                    options: [.prettyPrinted, .sortedKeys]) {
            return String(decoding: pretty, as: UTF8.self)
        }
        return String(decoding: data, as: UTF8.self)
    }
}
