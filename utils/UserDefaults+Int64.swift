import UIKit

extension UserDefaults {

    func set(_ value: Int64, forKey: String) {
        set(String(value), forKey: forKey)
    }
    
    func int64(forKey: String) -> Int64 {
        if let value = string(forKey: forKey) {
            return Int64(value) ?? 0
        }
        return 0
    }
    
}

