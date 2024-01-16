import UIKit
import SwiftyJSON

extension String {
    func json() -> JSON {
        return JSON(parseJSON: self)
    }
}

extension JSON {
    func string() -> String {
        if let str = self.rawString(.utf8, options: [.prettyPrinted, .sortedKeys]) {
            return str
        }
        else {
            return ""
        }
    }
}
