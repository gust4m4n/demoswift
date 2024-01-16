import Alamofire
import SwiftyJSON

class DemoApi {    
    static func get(endpoint: String, params: [String:Any]? = nil, headers: HTTPHeaders? = nil, contractFile: String = "", contract: Bool = false, completion: @escaping (_ resp : DemoApiResponse) -> Void) {
        
        var mutableHeaders = headers
        if mutableHeaders == nil {
            mutableHeaders = HTTPHeaders()
        }
        
        ApiX.get(url: DemoApi.apiUrl(endpoint), params: params, headers: mutableHeaders, contractFile: contractFile, contract: contract, completion: {(_ resp: ApiXResponse) in
            let newResp = DemoApiResponse(resp, "", "")
            newResp.json = resp.json
            newResp.mapJson()
            if handleResponse(newResp) == false {
                completion(newResp)
            }
        })
    }
    
    static func post(endpoint: String, params: [String:Any]? = nil, headers: HTTPHeaders? = nil, rawBody: String = "", contractFile: String = "", contract: Bool = false, completion: @escaping (_ resp : DemoApiResponse) -> Void) {
        
        var mutableHeaders = headers
        if mutableHeaders == nil {
            mutableHeaders = HTTPHeaders()
        }
        let mutableParams = params
        
        ApiX.post(url: DemoApi.apiUrl(endpoint), params: mutableParams, headers: mutableHeaders, rawBody: rawBody, contractFile: contractFile, contract: contract, completion: {(_ resp: ApiXResponse) in
            let newResp = DemoApiResponse(resp, "", "")
            newResp.json = resp.json
            newResp.mapJson()
            if handleResponse(newResp) == false {
                completion(newResp)
            }
        })
    }
    
    static func put(endpoint: String, params: [String:Any]? = nil, headers: HTTPHeaders? = nil, contractFile: String = "", contract: Bool = false, completion: @escaping (_ resp : DemoApiResponse) -> Void) {
        
        var mutableHeaders = headers
        if mutableHeaders == nil {
            mutableHeaders = HTTPHeaders()
        }
        let mutableParams = params
        
        ApiX.put(url: DemoApi.apiUrl(endpoint), params: mutableParams, headers: mutableHeaders, contractFile: contractFile, contract: contract, completion: {(_ resp: ApiXResponse) in
            let newResp = DemoApiResponse(resp, "", "")
            newResp.json = resp.json
            newResp.mapJson()
            if handleResponse(newResp) == false {
                completion(newResp)
            }
        })
    }
    
    static func upload(endpoint: String, jpegData: [Data], paramName: [String], fileName: [String], otherParams: [String:Any]? = nil, headers: HTTPHeaders? = nil, contractFile: String = "", contract: Bool = false, completion: @escaping (_ resp : DemoApiResponse) -> Void) {        
        ApiX.upload(url: DemoApi.apiUrl(endpoint), jpegData: jpegData, paramName: paramName, fileName: fileName, otherParams: otherParams, headers: headers, contractFile: contractFile, contract: contract, completion: {(_ resp: ApiXResponse) in
            let newResp = DemoApiResponse(resp, "", "")
            if handleResponse(newResp) == false {
                completion(newResp)
            }
        })
    }    

    static func handleResponse(_ resp: DemoApiResponse) -> Bool {
        if resp.statusCode == 401 {
            return false
        }
        return false
    }
    
}

class DemoApiResponse: ApiXResponse {
    init () {
        super.init()
    }
    
    init(_ resp: ApiXResponse, _ code: String = "", _ title: String = "") {
        super.init()
        self.statusCode = resp.statusCode
        self.message = resp.message
        self.json = resp.json
        self.raw = resp.raw
        self.headers = resp.headers
        self.mapJson()
    }
    
    func mapJson() {
        self.message = json["message"].stringValue
        if json["error"].stringValue.count > 0 {
            self.message = json["error"].stringValue
        }
        self.message = message
        
        if statusCode == ApiX.STATUSCODE_NO_INTERNET {
            self.message = NSLocalizedString("No internet connection.", comment: "")
        } else
        if statusCode == ApiX.STATUSCODE_TIMEOUT {
            self.message = NSLocalizedString("Please check your internet connection and try again.", comment: "")
        }
    }
}

