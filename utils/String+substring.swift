import UIKit

extension String {
        
    func substring(length : Int) -> String {
        if self.count > 0 && length > 0 {
            var len = length
            if len > self.count {
                len = self.count
            }
            let toIndex = self.index(self.startIndex, offsetBy: len-1)
            return String(self[...toIndex])
        } else {
            return ""
        }
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func containingCharacters(_ charSet: String) -> Bool {
        if self.count > 0 {
            let hexSet = CharacterSet(charactersIn: charSet)
            let newSet = CharacterSet(charactersIn: self)
            return hexSet.isSuperset(of: newSet)
        }
        return true
    }

        
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
                
}
