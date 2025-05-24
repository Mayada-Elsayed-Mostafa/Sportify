import Network
import UIKit

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    public private(set) var isConnected: Bool = false
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    print("Internet connection is available.")
                    
                    if let topVC = NetworkMonitor.getTopViewController(), topVC.presentedViewController == nil {
                        let alert = UIAlertController(title: "Internet Restored",
                                                      message: "Your internet connection is back online.",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        topVC.present(alert, animated: true)
                    }
                } else {
                    print("Internet connection is not available.")
                    
                    if let topVC = NetworkMonitor.getTopViewController(), topVC.presentedViewController == nil {
                        let alert = UIAlertController(title: "No Internet Connection",
                                                      message: "Please check your internet settings and try again.",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        topVC.present(alert, animated: true)
                    }
                }
            }
        }
        
        monitor.start(queue: queue)
    }

    
    private static func getTopViewController(base: UIViewController? = UIApplication.shared.connectedScenes
                                                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                                                .first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
