
import Foundation

enum Tab: String, CaseIterable {
    case request = "Request"
    case response = "Response"
    case curl = "cURL"
}


@Observable
class LogsDetailViewViewModel {
    
    let call: NetworkCall
    let onDismiss: () -> Void
    var selectedTab: Tab = .request
    
    private var curlText: String {
        var parts = ["curl -v \\"]
        let method = call.request.httpMethod ?? "GET"
        if method != "GET" { parts.append("  -X \(method) \\") }
        for (key, value) in call.request.allHTTPHeaderFields ?? [:] {
            parts.append("  -H '\(key): \(value)' \\")
        }
        if let body = call.request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            parts.append("  -d '\(bodyString)' \\")
        }
        parts.append("    '\(call.request.url?.absoluteString ?? "")'")
        return parts.joined(separator: "\n")
    }
    
    private var responseText: String {
        guard call.response != nil || call.data != nil else { return "No Response" }
        return call.responseHeaderText + "\n\n" + call.responseBody
    }
    
    private var requestText: String {
        var lines = [
            "URL: \(call.request.url?.absoluteString ?? "—")",
            "Method: \(call.request.httpMethod ?? "GET")",
            "Headers:"
        ]
        for (key, value) in call.request.allHTTPHeaderFields ?? [:] {
            lines.append("  \(key): \(value)")
        }
        return lines.joined(separator: "\n")
    }
    
    var currentTabText: String {
        switch selectedTab {
        case .request: return requestText
        case .response: return responseText
        case .curl: return curlText
        }
    }
    
    init(networkCall: NetworkCall, onDismiss: @escaping () -> Void) {
        self.call = networkCall
        self.onDismiss = onDismiss
    }
}
