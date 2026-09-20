
import Foundation

@MainActor
@Observable
class NetworkCallStore {
    static let shared = NetworkCallStore()
    
    private(set) var calls: [NetworkCall] = []
    
    func add(_ call: NetworkCall) {
        calls.insert(call, at: 0)
    }
    
    func removeAll() {
        calls.removeAll()
    }
}
