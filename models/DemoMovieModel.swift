import Foundation
import SwiftyJSON

class DemoMovieModel {
    var id: Int64 = 0
    var poster = ""
    var revenue: Int64 = 0
    var title = ""

    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].int64Value
        self.poster = json["poster"].stringValue.urlString()
        self.revenue = json["revenue"].int64Value
        self.title = json["title"].stringValue
    }
}


