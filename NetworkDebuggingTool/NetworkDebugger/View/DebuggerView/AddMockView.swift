
import SwiftUI

struct AddMockView: View {
    @Binding var viewModel: MockViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Add Mock").font(.headline)
            Text("Enter mock details.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.top, 2)
            
            VStack(spacing: 0) {
                field("URL Pattern (e.g., /users)", text: $viewModel.urlPattern, autocaps: .never)
                field("HTTP Method (GET, POST – optional)", text: $viewModel.httpMethod, autocaps: .characters)
                field("JSON File Name (e.g., users.json)", text: $viewModel.jsonFileName, autocaps: .never)
                field("Status Code", text: $viewModel.statusText, keyboard: .numberPad, showDivider: false)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(.top, 16)
            
            HStack(spacing: 12) {
                pillButton("Cancel") { viewModel.showAddMockScreen = false }
                pillButton("Save", disabled:!viewModel.canSave) { viewModel.addMock() }
            }
            .padding(.top, 20)
        }
        .padding(20)
        .background(Color(.systemBackground),
                    in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.15), radius: 20, y: 8)
        
    }
    
    private func field(_ placeholder: String,
                       text: Binding<String>,
                       autocaps: TextInputAutocapitalization = .sentences,
                       keyboard: UIKeyboardType = .default,
                       showDivider: Bool = true) -> some View {
        VStack(spacing: 0) {
            TextField(placeholder, text: text)
                .textInputAutocapitalization(autocaps)
                .autocorrectionDisabled()
                .keyboardType(keyboard)
                .padding(12)
            if showDivider { Divider().padding(.horizontal, 12) }
        }
        .background(Color(.systemGray3))

    }
    
    private func pillButton(_ title: String,
                            disabled: Bool = false,
                            action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color(.systemGray3),
                            in: RoundedRectangle(cornerRadius: 25, style: .continuous))
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(disabled)
        .opacity(disabled ? 0.4 : 1)
    }
}

#Preview {
    @Previewable @State var viewModel: MockViewModel = .init()
    AddMockView(viewModel: $viewModel)
}
