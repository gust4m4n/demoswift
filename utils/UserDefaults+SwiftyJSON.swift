import UIKit
import SwiftyJSON

extension UserDefaults {

    func set(_ value: JSON, forKey: String) {
        set(value.rawString(), forKey: forKey)
    }
    
    func json(forKey: String) -> JSON {
        if let value = string(forKey: forKey) {
            return JSON(parseJSON: value)
        } else {
            return JSON()
        }
    }
    
}

