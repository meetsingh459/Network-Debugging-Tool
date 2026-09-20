
import SwiftUI

struct LogsDetailView: View {
    
    @State private var viewModel: LogsDetailViewViewModel
    
    init(viewModel: LogsDetailViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 16) {
            header
            
            Picker("", selection: $viewModel.selectedTab) {
                ForEach(Tab.allCases, id: \.self) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            ScrollView {
                Text(viewModel.currentTabText)
                    .font(.system(.body, design: .monospaced))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textSelection(.enabled)
                    .padding(.horizontal)
            }
            
            Spacer(minLength: 0)
        }
        .padding(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(.systemBackground))
    }

    
    private var header: some View {
        HStack {
            ShareLink(item: viewModel.currentTabText) {
                Image(systemName: "square.and.arrow.up")
                    .foregroundStyle(.primary)
                    .frame(width: 44, height: 44)
                    .background(Color(.systemGray6), in: Circle())
            }
            Spacer()
            Text("Call Details").font(.title2).bold()
            Spacer()
            Button(action: viewModel.onDismiss) {
                Image(systemName: "checkmark")
                    .font(.body.weight(.bold))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.blue, in: Circle())
            }
        }
        .padding(.horizontal)
    }
}
