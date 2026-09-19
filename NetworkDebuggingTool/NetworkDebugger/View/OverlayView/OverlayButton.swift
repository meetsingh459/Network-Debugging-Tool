
import SwiftUI

struct OverlayButton: View {
    
    var tapAction: () -> Void
    private let size: CGFloat = 44
    
    init(tapAction: @escaping () -> Void) {
        self.tapAction = tapAction
    }
    
    var body: some View {
        Image(systemName: "slider.horizontal.3")
            .font(.system(size: 20, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 44, height: 44)
            .background(Color(white: 0.2).opacity(0.6),
                        in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(color: .black.opacity(0.25), radius: 5, y: 3)
            .contentShape(Rectangle())   // whole 44×44 is tappable
            .onTapGesture { tapAction() }
    }
}

#Preview {
    OverlayButton() { }
}

