
import Foundation

@Observable
final class MockStore {
    
    static let shared = MockStore()
    
    private(set) var mocks: [Mock] = [
        Mock(urlPattern: "your-api-endpoint.com/some/path", jsonFileName: "sample_user.json"),
        Mock(urlPattern: "your-api-endpoint.com/some/path2", jsonFileName: "sample_user.json", isEnabled: true),
        Mock(urlPattern: "your-api-endpoint.com/some/path", jsonFileName: "sample_user.json"),
        Mock(urlPattern: "your-api-endpoint.com/some/path2", jsonFileName: "sample_user.json", isEnabled: true),
    ]
    
    func addMock(_ mock: Mock) {
        mocks.append(mock)
    }
    
    func deleteMock(_ mock: Mock) {
        mocks.removeAll { $0.id == mock.id }
    }
    
    func setEnabled(_ isEnabled: Bool, for mock: Mock) {
        guard let i = mocks.firstIndex(where: { $0.id == mock.id }) else {
            return
        }
        
        mocks[i].isEnabled = isEnabled
    }
}
