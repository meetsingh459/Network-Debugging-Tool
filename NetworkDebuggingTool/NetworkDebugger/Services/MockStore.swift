
import Foundation

@Observable
final class MockStore {
    
    static let shared = MockStore()
    
    nonisolated(unsafe) private(set) static var enabledSnapshot: [Mock] = []
    
    private(set) var mocks: [Mock] = [
        Mock(urlPattern: "https://api.dictionaryapi.dev/api/v2/entries/en/dog", jsonFileName: "sample_user.json"),
        Mock(urlPattern: "https://api.dictionaryapi.dev/api/v2/entries/en/cat", jsonFileName: "sample_user.json"),
        Mock(urlPattern: "https://api.dictionaryapi.dev/api/v2/entries/en/human", jsonFileName: "sample_user.json"),
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
        refreshSnapshot()
    }
    
    private func refreshSnapshot() {
        Self.enabledSnapshot = mocks.filter{ $0.isEnabled }
    }
}
