
import SwiftUI

enum DebuggerTabs: String, CaseIterable {
    case logs = "Logs"
    case mocks = "Mocks"
}

struct DebuggerPanel: View {
    
    @State private var selectedTab: DebuggerTabs = .logs
    var onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Spacer()
                Button(action:onDismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal)
            
            HStack {
                Picker("", selection:$selectedTab) {
                    ForEach(DebuggerTabs.allCases, id: \.self) { tab in
                        Text(tab.rawValue.capitalized)
                            .foregroundColor(.primary)
                            .tag(tab)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.horizontal)
            
            switch selectedTab {
            case .logs:
                LogsView()
            case .mocks:
                MocksView()
            }
            
            Spacer(minLength: 0)
        }
        .padding(.top)
        .background(Color(.systemBackground))
    }
}


#Preview {
    DebuggerPanel() {
        
    }
}
