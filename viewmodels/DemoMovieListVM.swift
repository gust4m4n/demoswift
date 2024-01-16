import SwiftyJSON
import Alamofire

class DemoMovieListVM {
    var list: [DemoMovieModel] = []

    func request(completion: @escaping (_ resp: DemoApiResponse) -> Void) {
        DemoApi.get(endpoint: "/api/movie/list", params: nil, headers: DemoApi.authHeaders(reqName: "ContactList"), contractFile: "DemoMovieListContract.json", contract: true, completion: {(_ resp: ApiXResponse) in
            
            self.list = []
            if resp.json["status"].intValue == 200 {
                for item in resp.json["result"].arrayValue {
                    self.list.append(DemoMovieModel(json: item))
                }
            }
            completion(DemoApiResponse(resp))
            
        })
    }
      
}
