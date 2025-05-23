import SwiftUI
import Combine
import Cashik_Logger

class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    let logger = Logger()
    
    func navigateTo(destination: DestinationModule) {
        path.append(destination)
        logger.log("path: \(path), destination: \(destination)")
        
    }
    
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func reset() {
        path = NavigationPath()
    }
}

enum DestinationModule: Hashable {
    case onboarding
    case newUser
    case authorization
}
