import UIKit

extension String {
    var isPhoneNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "+0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }

    func validEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: self)
    }

    func validUsername() -> Bool {
        let regEx = "^[a-z0-9_-]{6,255}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: self)
    }

    func validPhoneNumber() -> Bool {
        let regEx = "^((\\+)|(00))[0-9]{6,14}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: self)
    }
    
    func maskedPhoneNumber() -> String {
        let limit = 4
        if self.count > limit {
            let prefix = String(repeating: "*", count: self.count-3)
            let suffix = self.suffix(limit)
            return prefix + suffix
        } else {
            return String(repeating: "*", count: self.count)
        }
    }
    
    func maskedPhoneNumberSuffix(_ count : Int) -> String {
        return self.dropLast(count) + String(repeating: "*", count: count)
    }

    func maskedCustomerName() -> String {
        let limit = 18
        if self.count > limit {
            let prefix = self.prefix(limit)
            return prefix + "***"
        } else {
            return self
        }
    }
    
    func maskedAccountNumber() -> String {
        return "****" + self.suffix(4)
    }

    func maskedLabelName(_ n: Int = 5, reversed: Bool = false) -> String {
        let mask = String(repeating: "*", count: Swift.max(0, count-n))
        return reversed ? mask + suffix(n) : prefix(n) + mask
    }
    
    func trimmedPhoneNumber() -> String {
        var value = self
        value = value.replacingOccurrences(of: " ", with: "")
        value = value.replacingOccurrences(of: "-", with: "")
        value = value.replacingOccurrences(of: "(", with: "")
        value = value.replacingOccurrences(of: ")", with: "")
        return value
    }
    
    func maskedEmailAddress() -> String {
        if self.count > 0 {
            let mask = "********"
            let email = self
            let components = email.components(separatedBy: "@")
            var masked = ""
            if let value = components.first {
                if value.count <= mask.count {
                    masked = mask
                } else {
                    let limit = value.count - mask.count
                    let prefix = value.prefix(limit)
                    masked = prefix + mask
                }
            } else {
                masked = mask
            }
            var host = ""
            if let value = components.last {
                host = value
            }
            return "\(masked)@\(host)"
        } else {
            return ""
        }
    }

}
