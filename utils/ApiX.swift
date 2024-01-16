import UIKit
import Alamofire
import SwiftyJSON
import Reachability

class ApiXResponse {
    var statusCode: Int = 0
    var message: String = ""
    var json: JSON = JSON()
    var raw: String = ""
    var headers: [AnyHashable : Any] = [:]
    
    init(_ statusCode: Int = 0, _ message: String = "", _ json: JSON = JSON(), _ raw: String = "", _ headers: [AnyHashable : Any] = [:]) {
        self.statusCode = statusCode
        self.message = message
        self.json = json
        self.raw = raw
        self.headers = headers
    }
}

class ApiX {
    static let STATUSCODE_NO_INTERNET = -111
    static let STATUSCODE_UNSTABLE_INTERNET = -222
    static let STATUSCODE_UNKNOWN = -333
    static let STATUSCODE_SERVER_TRUST_ERROR = -444
    static let STATUSCODE_TIMEOUT = -555
    static var manager = Session.default
    static var activityIndicatorCount: Int = 0
    static var contractDelay: Double = 0.25
        
    static func cancellAllRequests() {
        ApiX.manager.cancelAllRequests()
    }
    
    static func handleContract(url: String, contractFile: String = "", contract: Bool = false, completion: @escaping (_ resp : ApiXResponse) -> Void) -> Bool {
        if contract == true {
            DispatchQueue.main.asyncAfter(deadline: .now() + contractDelay) {
                let body = JSON(res: contractFile)
                let bodyRaw = body.string()
                LoggerX.log("200 '\(url)' contractFile: \(contractFile)\n\(bodyRaw)")
                completion(ApiXResponse(200, "", body, bodyRaw, [:]))
            }
            return true
        } else {
            return false
        }
    }
    
    static func handleInternetConnection(url: String, completion: @escaping (_ resp : ApiXResponse) -> Void) -> Bool {
        if Reachability.internetAvailable() == false {
            completion(ApiXResponse(ApiX.STATUSCODE_NO_INTERNET, "No internet connection.", JSON(), "", [:]))
            return true
        } else {
            return false
        }
    }
    
    static func handleDataResponse(response: AFDataResponse<Data?>, completion: @escaping (_ resp : ApiXResponse) -> Void) {
        switch response.result {
            case .success(_):
                break
            case .failure(let error):
                if let urlError = error.underlyingError as? URLError {
                    if urlError.code.rawValue == -1001 {
                        completion(ApiXResponse(ApiX.STATUSCODE_TIMEOUT, "Connection timeout. (\(urlError.code.rawValue).", JSON(), "", response.response?.allHeaderFields ?? [:]))
                        return
                    } else
                    if urlError.code.rawValue == -1009 {
                        completion(ApiXResponse(ApiX.STATUSCODE_NO_INTERNET, "No internet connection (\(urlError.code.rawValue).", JSON(), "", response.response?.allHeaderFields ?? [:]))
                        return
                    } else {
                        completion(ApiXResponse(ApiX.STATUSCODE_UNSTABLE_INTERNET, "Unstable internet connection (\(urlError.code.rawValue).", JSON(), "", response.response?.allHeaderFields ?? [:]))
                        return
                    }
                } else {
                    if let _ = error.asAFError?.isServerTrustEvaluationError {
                        completion(ApiXResponse(ApiX.STATUSCODE_SERVER_TRUST_ERROR, error.localizedDescription, JSON(), "", response.response?.allHeaderFields ?? [:]))
                        return
                    } else {
                        completion(ApiXResponse(ApiX.STATUSCODE_UNKNOWN, error.localizedDescription, JSON(), "", response.response?.allHeaderFields ?? [:]))
                        return
                    }
                }
        }
        
        let statusCode = response.response?.statusCode ?? 0
        var raw: String = ""
        if let data = response.data {
            if let value = String(data: data, encoding: .utf8) {
                raw = value
            }
        }
        let json = JSON(parseJSON: raw)
        if json == JSON.null {
            completion(ApiXResponse(statusCode, raw, json, raw, response.response?.allHeaderFields ?? [:]))
            return
        }
        completion(ApiXResponse(statusCode, "", json, raw, response.response?.allHeaderFields ?? [:]))
    }
    
    static func jsonHttpRequest(url: String, params: [String:Any]? = nil, headers: HTTPHeaders? = nil, rawBody: String = "", httpMethod: String) -> URLRequest {
        let jsonBody = JSON(params as Any)        
        let url = URL(string: url)!
        var jsonParams = ""
        if let value = jsonBody.rawString(options: []) {
            jsonParams = value
        }
        var jsonData = jsonParams.data(using: .utf8, allowLossyConversion: false)!
        if rawBody.count > 0 {
            jsonData = rawBody.data(using: .utf8, allowLossyConversion: false)!
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        if headers != nil {
            request.headers = headers!
        }
        return request
    }

    static func get(url: String, params: [String:Any]? = nil, headers: HTTPHeaders? = nil, contractFile: String = "", contract: Bool = false, completion: @escaping (_ resp : ApiXResponse) -> Void) {
        
        if handleContract(url: url, contractFile: contractFile, contract: contract, completion: completion) == true {
            return
        }
        if handleInternetConnection(url: url, completion: completion) == true {
            return
        }
        
        activityIndicatorCount = activityIndicatorCount + 1
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        ApiX.manager.request(url, method: .get, parameters: params, headers: headers).response { response in
            activityIndicatorCount = activityIndicatorCount - 1
            if (activityIndicatorCount <= 0) {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            handleDataResponse(response: response, completion: completion)
        }
    }

    static func post(url: String, params: [String:Any]? = nil, headers: HTTPHeaders? = nil, encoding: ParameterEncoding = JSONEncoding.default, rawBody: String = "", contractFile: String = "", contract: Bool = false, completion: @escaping (_ resp : ApiXResponse) -> Void) {
        
        if handleContract(url: url, contractFile: contractFile, contract: contract, completion: completion) == true {
            return
        }
        if handleInternetConnection(url: url, completion: completion) == true {
            return
        }

        activityIndicatorCount = activityIndicatorCount + 1
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let request = jsonHttpRequest(url: url, params: params, headers: headers, rawBody: rawBody, httpMethod: HTTPMethod.post.rawValue)
        ApiX.manager.request(request).response { response in
            activityIndicatorCount = activityIndicatorCount - 1
            if (activityIndicatorCount <= 0) {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            handleDataResponse(response: response, completion: completion)
        }
    }
    
    static func put(url: String, params: [String:Any]? = nil, headers: HTTPHeaders? = nil, encoding: ParameterEncoding = JSONEncoding.default, rawBody: String = "", contractFile: String = "", contract: Bool = false, completion: @escaping (_ resp : ApiXResponse) -> Void) {
        
        if handleContract(url: url, contractFile: contractFile, contract: contract, completion: completion) == true {
            return
        }
        if handleInternetConnection(url: url, completion: completion) == true {
            return
        }

        activityIndicatorCount = activityIndicatorCount + 1
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let request = jsonHttpRequest(url: url, params: params, headers: headers, rawBody: rawBody, httpMethod: HTTPMethod.put.rawValue)
        ApiX.manager.request(request).response { response in
            activityIndicatorCount = activityIndicatorCount - 1
            if (activityIndicatorCount <= 0) {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            handleDataResponse(response: response, completion: completion)
        }
    }
    
    static func upload(url: String, jpegData: [Data], paramName: [String], fileName: [String], otherParams: [String:Any]? = nil, headers: HTTPHeaders? = nil, contractFile: String = "", contract: Bool = false, completion: @escaping (_ resp : ApiXResponse) -> Void) {

        if handleContract(url: url, contractFile: contractFile, contract: contract, completion: completion) == true {
            return
        }
        if handleInternetConnection(url: url, completion: completion) == true {
            return
        }

        activityIndicatorCount = activityIndicatorCount + 1
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        AF.upload(multipartFormData: { multipartFormData in
            
            if jpegData.count > 0 && paramName.count > 0 && fileName.count > 0 {
                for i in 0..<jpegData.count {
                    multipartFormData.append(jpegData[i], withName: paramName[i], fileName: fileName[i], mimeType: "image/jpeg")
                }
            }
            
            if otherParams != nil && otherParams!.count > 0 {
                for (key, value) in otherParams! {
                    multipartFormData.append(Data((value as! String).utf8), withName: key)
                }
            }
           },
           to: url, method: .post , headers: headers)
           .response { response in
               activityIndicatorCount = activityIndicatorCount - 1
               if (activityIndicatorCount <= 0) {
                   UIApplication.shared.isNetworkActivityIndicatorVisible = false
               }
               
               handleDataResponse(response: response, completion: completion)
           }
    }
    
    static func DELETE(url: String, params: [String:Any]? = nil, headers: HTTPHeaders? = nil, encoding: ParameterEncoding = JSONEncoding.default, completion: @escaping (_ statusCode: Int, _ errMsg: String, _ json: JSON, _ raw: String) -> Void) {

        if Reachability.internetAvailable() == false {
            completion(ApiX.STATUSCODE_NO_INTERNET, "No internet connection.", JSON(), "")
            return
        }

        activityIndicatorCount = activityIndicatorCount + 1
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        ApiX.manager.request(url, method: .delete, parameters: params, encoding: encoding, headers: headers).response { response in
            activityIndicatorCount = activityIndicatorCount - 1
            if (activityIndicatorCount <= 0) {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            switch response.result {
            case .success(_):
                break
            case .failure(let error):
                if let urlError = error.underlyingError as? URLError {
                    if urlError.code.rawValue == -1009 {
                        completion(ApiX.STATUSCODE_NO_INTERNET, "No internet connection (\(urlError.code.rawValue).", JSON(), "")
                        return
                    } else {
                        completion(ApiX.STATUSCODE_UNSTABLE_INTERNET, "Unstable internet connection (\(urlError.code.rawValue).", JSON(), "")
                        return
                    }
                } else {
                    if let _ = error.asAFError?.isServerTrustEvaluationError {
                        completion(ApiX.STATUSCODE_SERVER_TRUST_ERROR, error.localizedDescription, JSON(), "")
                    } else {
                        completion(ApiX.STATUSCODE_UNKNOWN, error.localizedDescription, JSON(), "")
                    }
                    return
                }
            }

            let statusCode = response.response?.statusCode ?? 0
            var raw: String = ""
            if let data = response.data {
                if let value = String(data: data, encoding: .utf8) {
                    raw = value
                }
            }
            let json = JSON(parseJSON: raw)
            if json == JSON.null {
                completion(statusCode, raw, JSON(), raw)
                return
            }
            completion(statusCode, "", json, raw)
        }
    }
    
    static func DOWNLOAD(url: String, fileName: String, params: [String:Any]? = nil, headers: HTTPHeaders? = nil, completion: @escaping (_ statusCode: Int, _ errMsg: String, _ filePath: String) -> Void) {

        if Reachability.internetAvailable() == false {
            completion(ApiX.STATUSCODE_NO_INTERNET, "No internet connection.", "")
            return
        }
        
        let destinationPath: DownloadRequest.Destination = { _, _ in
             let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0];
             let fileURL = documentsURL.appendingPathComponent(fileName)
             return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
         }
        
        activityIndicatorCount = activityIndicatorCount + 1
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        ApiX.manager.download(url, method: .get, parameters: params, headers: headers, to: destinationPath ).response { response in
            activityIndicatorCount = activityIndicatorCount - 1
            if (activityIndicatorCount <= 0) {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            switch response.result {
            case .success(_):
                break
            case .failure(let error):
                if let urlError = error.underlyingError as? URLError {
                    if urlError.code.rawValue == -1009 {
                        completion(ApiX.STATUSCODE_NO_INTERNET, "No internet connection (\(urlError.code.rawValue).", "")
                        return
                    } else {
                        completion(ApiX.STATUSCODE_UNSTABLE_INTERNET, "Unstable internet connection (\(urlError.code.rawValue).", "")
                        return
                    }
                } else {
                    if let _ = error.asAFError?.isServerTrustEvaluationError {
                        completion(ApiX.STATUSCODE_SERVER_TRUST_ERROR, error.localizedDescription, "")
                    } else {
                        completion(ApiX.STATUSCODE_UNKNOWN, error.localizedDescription, "")
                    }
                    return
                }
            }
                        
            let statusCode = response.response?.statusCode ?? 0
            if response.fileURL != nil, let filePath = response.fileURL?.absoluteString {
                completion(statusCode, "", filePath)
                return
            } else {
                completion(statusCode, "", "")
            }
        }
    }
    
}

