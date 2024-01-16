import UIKit

extension String {
    
    func data() -> Data {
        var returnValue: [UInt8] = []
        let charByte = self.utf8.map { UInt8($0) }
        for i in 0..<self.count {
            returnValue.append(charByte[i])
        }
        return Data(bytes: returnValue, count: returnValue.count)
    }

}

extension Data {
    
    func string() -> String {
        return String(decoding: self, as: UTF8.self)/* {
            return str
        } else {
            return String()
         } */
    }

}


extension String {
    
    func stringUInt8() -> String {
        var returnValue: [UInt8] = []
        let charByte = self.utf8.map { UInt8($0) }
        for i in 0..<self.count {
            returnValue.append(charByte[i])
        }
        return String(bytes: returnValue, encoding: .utf8) ?? ""
    }
    
    func dataUInt8() -> Data {
        var returnValue: [UInt8] = []
        let charByte = self.utf8.map { UInt8($0) }
        for i in 0..<self.count {
            returnValue.append(charByte[i])
        }
        return Data(bytes: returnValue, count: returnValue.count)
    }

    
}
