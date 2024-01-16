import UIKit
import WebKit

extension UIApplication {
    static func openTo(_ url: String) {
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
        }
    }

    static func callTo(_ phoneNumber: String) {
        openTo("tel://\(phoneNumber)")
    }
    
    static func emailTo(_ address: String) {
        openTo("mailto:\(address)")
    }
    
    static func navigateTo(_ url: String) {
        openTo(url)
    }
    
    static func smsTo(_ phoneNumber: String) {
        openTo("sms:\(phoneNumber)")
    }
    
    static func whatsappTo(_ phoneNumber: String) {
        openTo("whatsapp://\(phoneNumber)")
    }

}
