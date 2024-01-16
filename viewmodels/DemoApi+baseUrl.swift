import UIKit
import Alamofire

extension DemoApi {
    static var baseUrl = ""
    static var encrypted = false

    static func loadBaseUrlDev() {
    }
    
    static func apiUrl(_ endpoint: String) -> String {
        if endpoint.lowercased().hasPrefix("http://") || endpoint.lowercased().hasPrefix("https://") {
            return endpoint
        } else {
             return baseUrl + endpoint
        }
    }

}




