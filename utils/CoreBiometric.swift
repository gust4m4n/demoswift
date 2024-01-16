import UIKit
import Foundation
import LocalAuthentication

class CoreBiometric {
    static var requesting = false
    
    static func isSupported() -> Bool {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            if error == nil {
                if #available(iOS 11.2, *) {
                    if context.biometryType == LABiometryType.none {
                        return false
                    } else {
                        return true
                    }
                } else {
                    return false
                }
            }
        }
        return false
    }
    
    static func supportedBiometricType() -> LABiometryType {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            if error == nil {
                if #available(iOS 11.2, *) {
                    return context.biometryType
                } else {
                    return .touchID
                }
            }
        }
        return .touchID
    }
    
    static func request(completion: @escaping (_ success: Bool) -> Void) {
        if isSupported() == true {
            requesting = true
            let context = LAContext()
            context.localizedFallbackTitle = ""
            let reason = NSLocalizedString("Biometric Authentication", comment: "")
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                success, authenticationError in
                DispatchQueue.main.async {
                    requesting = false
                    completion(success)
                    return
                }
            }
        } else {
            completion(false)
        }
    }

    
}
