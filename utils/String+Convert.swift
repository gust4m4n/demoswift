import UIKit

extension String {
    func intValue() -> Int {
        if self.count > 0 {
            if let value = Int(self) {
                return value
            }
            return 0
        }
        else {
            return 0
        }
    }
    
    func int64Value() -> Int64 {
        if self.count > 0 {
            if let value = Int64(self) {
                return value
            }
            return 0
        }
        else {
            return 0
        }
    }
    
    func doubleValue() -> Double {
        if self.count > 0 {
            if let value = Double(self) {
                return value
            }
            return 0.0
        }
        else {
            return 0.0
        }
    }
    
}
