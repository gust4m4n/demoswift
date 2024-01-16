import UIKit
import Foundation
import Reachability

extension Reachability {
    
    static func internetAvailable() -> Bool {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            return false
        }
        return true
    }

}
