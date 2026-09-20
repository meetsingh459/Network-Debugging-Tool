
import SwiftUI

struct LogsView: View {
    
    @State var viewModel = NetworkCallViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button("Clean All") {
                    viewModel.clearAllLogs()
                }
                .font(.system(size: 14))
            }
            .padding(.horizontal)
            
            if viewModel.isEmpty {
                Spacer()
                Text("No network calls yet").foregroundStyle(.secondary)
                Spacer()
            } else {
                List(viewModel.networkCalls) { call in
                    Button {
                        viewModel.selectedCell = call
                    } label: {
                        HStack {
                            Text(call.method).font(.caption).bold().frame(width: 42, alignment: .leading)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(call.path).font(.caption).lineLimit(1)
                                if let host = call.host {
                                    Text(host).font(.caption2).foregroundStyle(.secondary)
                                }
                            }
                            Spacer()
                            Text(viewModel.statusText(call)).font(.caption).bold().foregroundStyle(viewModel.statusColor(call))
                        }
                    }
                    .buttonStyle(.plain)
                }
                .listStyle(.plain)
                .sheet(item: $viewModel.selectedCell) { call in
                    let logsDetailViewModel = LogsDetailViewViewModel(networkCall: call) {
                        viewModel.selectedCell = nil
                    }
                    
                    LogsDetailView(viewModel: logsDetailViewModel)
                }
            }
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
