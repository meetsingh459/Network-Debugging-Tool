
import SwiftUI

final class NetworkDebugger {
    static let shared = NetworkDebugger()
    private init() {}

    private var window: OverlayWindow?
    
    func start() {
        guard window == nil else { return }

        let windowScenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
        guard let scene = windowScenes.first(where: { $0.activationState == .foregroundActive }) ?? windowScenes.first else {
            return
        }

        let bounds: CGRect
        if #available(iOS 26.0, *) {
            bounds = scene.effectiveGeometry.coordinateSpace.bounds
        } else {
            bounds = scene.coordinateSpace.bounds
        }
        
        let container = UIViewController()
        container.view.backgroundColor = .clear
        
        // The button, hosted, added as a child of the container.
        let host = UIHostingController(rootView: OverlayButton { [weak self] in
            self?.showDebuggerView()
        })
        host.view.backgroundColor = .clear
        container.addChild(host)
        
        let window = OverlayWindow(windowScene: scene)
        window.frame = bounds
        window.windowLevel = .normal + 1
        window.rootViewController = container
        window.installButton(host.view, at: CGPoint(x: bounds.maxX - 40, y: 120))
        host.didMove(toParent: container)
        window.isHidden = false
        self.window = window
    }

    func stop() {
        window?.isHidden = true
        window = nil
    }
    
    func showDebuggerView() {
        guard let rootViewController = window?.rootViewController,
              rootViewController.presentedViewController == nil else {
            return
        }
        
        let debuggerPanel = UIHostingController(rootView: DebuggerPanel(onDismiss: {
            rootViewController.dismiss(animated:true)
        }))
        
        debuggerPanel.modalPresentationStyle = .overFullScreen
        rootViewController.present(debuggerPanel, animated: true)
    }
}
