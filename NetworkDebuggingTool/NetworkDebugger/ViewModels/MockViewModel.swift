
import Foundation

@Observable
final class MockViewModel {
    
    private let store = MockStore.shared
    
    var showAddMockScreen = false
    
    var mocks: [Mock] { store.mocks }
    
    // Add mock form fields
    var urlPattern = ""
    var httpMethod = ""
    var jsonFileName = ""
    var statusText = "200"
    
    var canSave: Bool {
        !urlPattern.trimmingCharacters(in: .whitespaces).isEmpty &&
        !jsonFileName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func addMock() {
        let mock = Mock(urlPattern: urlPattern, httpMethod: httpMethod, jsonFileName: jsonFileName, statusCode: Int(statusText) ?? 200)
        store.addMock(mock)
        showAddMockScreen = false
    }
    
    func deleteMock(_ mock: Mock) {
        store.deleteMock(mock)
    }
    
    func setEnabled(_ enabled: Bool, for mock: Mock) {
        store.setEnabled(enabled, for: mock)
    }
}
