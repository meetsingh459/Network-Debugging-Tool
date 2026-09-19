
import SwiftUI

struct LogsView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                ToolbarButton(title: "Clear All") {
                    
                }
                ToolbarButton(title: "Refresh") {
                    
                }
            }
            .padding(.horizontal)
            
            Divider()
    
            Spacer()
            
            Text("TODO to implement logs")
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct ToolbarButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(.vertical,10)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .font(.footnote)
        }
    }
}

#Preview {
    LogsView()
}
