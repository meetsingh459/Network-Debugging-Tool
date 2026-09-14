
import SwiftUI

struct SearchBar: View {
    
    @Binding var query: String
    var searchReult: () async -> Void

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
                .padding(.leading, 10)
                .padding(.trailing, 1)
           
            TextField("Search result...", text:$query)
                .textFieldStyle(.plain)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(5)
                .onSubmit {
                    Task {
                        await searchReult()
                    }
                }
        }
        .background(Color(.systemGray6), in:.rect(cornerRadius:10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .font(Font.system(size: 12, weight: .regular, design: .default))
        .frame(height: 48)
        .padding(.horizontal, 10)
    }

}
