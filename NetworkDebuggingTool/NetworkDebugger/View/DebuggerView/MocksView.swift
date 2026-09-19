import SwiftUI

struct MocksView: View {
    
    @State private var viewModel = MockViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button("Add Mock") {
                    viewModel.showAddMockScreen = true
                }
                .font(.system(size: 14))
            }
            .padding(.horizontal)
            
            List(viewModel.mocks) { mock in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(mock.httpMethod) - \(mock.urlPattern)")
                            .font(.caption)
                            .bold()
                        
                        Text("File: \(mock.jsonFileName), Status:\(mock.statusCode)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Toggle("", isOn: Binding(
                        get: { mock.isEnabled },
                        set: { viewModel.setEnabled($0, for:mock) }
                    ))
                    .labelsHidden()
                    .controlSize(.small)
                }
            }
            .listStyle(.plain)
            .overlay {
                if viewModel.showAddMockScreen {
                    ZStack {
                        Color.black.opacity(0.4).ignoresSafeArea()
                            .onTapGesture {
                                viewModel.showAddMockScreen = false
                            }
                        
                        AddMockView(viewModel: $viewModel)
                            .frame(maxWidth: 320)
                            .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 20)
                            .padding(40)
                        
                    }
                }
            }
            
        }
    }
}


#Preview {
    MocksView()
}
