
import Foundation
import SwiftUI

@Observable
class NetworkCallViewModel {
    
    let store = NetworkCallStore.shared
    
    var selectedCell: NetworkCall? = nil
    
    var networkCalls: [NetworkCall] {
        store.calls
    }
    
    var isEmpty: Bool {
        store.calls.isEmpty
    }
    
    func clearAllLogs() {
        store.removeAll()
    }
    
    func statusText(_ call: NetworkCall) -> String {
        call.error != nil ? "ERR" : (call.statusCode.map(String.init) ?? "—")
    }
    
    func statusColor(_ call: NetworkCall) -> Color {
        if call.error != nil {
            return .red
        }
        switch call.statusCode ?? 0 {
        case 200..<300: return .green
        case 400..<500: return .orange
        case 500...:    return .red
        default:        return .gray
        }
    }
}
