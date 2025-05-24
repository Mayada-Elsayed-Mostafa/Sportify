import Network
import UIKit

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private(set) var isConnected: Bool = false

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            self.isConnected = (path.status == .satisfied)
            print("Network status changed:", self.isConnected ? "Connected" : "Disconnected")
        }
        monitor.start(queue: queue)
    }

    func isInternetAvailable() -> Bool {
        return monitor.currentPath.status == .satisfied
    }
}

