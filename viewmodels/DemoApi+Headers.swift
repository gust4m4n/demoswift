import UIKit
import Alamofire

extension DemoApi {
    
    static func headers(reqName: String) -> HTTPHeaders {
        return [
            "device-id" : DemoPreferencesVM.getDeviceId(),
            "request-name" : reqName,
        ] as HTTPHeaders
    }

    static func authHeaders(reqName: String) -> HTTPHeaders {
        var headers = DemoApi.headers(reqName: reqName)
        headers["Authorization"] = "Bearer \(DemoPreferencesVM.getAccessToken())"
        return headers
    }
        
}


