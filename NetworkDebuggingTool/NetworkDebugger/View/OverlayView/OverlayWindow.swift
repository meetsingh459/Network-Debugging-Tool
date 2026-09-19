
import UIKit

final class OverlayWindow: UIWindow {

    private let size: CGFloat = 44
    private var buttonView: UIView?          // the hosting controller's view (the button)

    /// Called once by NetworkDebugger after the rootViewController is set.
    func installButton(_ view: UIView, at center: CGPoint) {
        buttonView = view
        view.frame = CGRect(x: center.x - size/2, y: center.y - size/2,
                            width: size, height: size)
        view.backgroundColor = .clear
        view.addGestureRecognizer(
            UIPanGestureRecognizer(target: self, action: #selector(handleDrag(_:))))
        rootViewController?.view.addSubview(view)   // subview of the container, NOT the root itself
    }

    @objc private func handleDrag(_ g: UIPanGestureRecognizer) {
        guard let view = buttonView else { return }
        let t = g.translation(in: self)
        var c = CGPoint(x: view.center.x + t.x, y: view.center.y + t.y)

        // clamp inside the screen, minus safe-area-ish margins
        let area = bounds.inset(by: UIEdgeInsets(top: 60, left: 12, bottom: 40, right: 12))
        c.x = min(max(c.x, area.minX + size/2), area.maxX - size/2)
        c.y = min(max(c.y, area.minY + size/2), area.maxY - size/2)

        view.center = c
        g.setTranslation(.zero, in: self)
    }

    // Only touches on the button belong to this window; everything else falls through.
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // Panel presented → whole window is interactive so it can receive taps.
        if rootViewController?.presentedViewController != nil {
            return true
        }
        
        return buttonView?.frame.contains(point) ?? false
    }
}
