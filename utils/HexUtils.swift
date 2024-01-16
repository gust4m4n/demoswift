import UIKit
import CommonCrypto

extension Data {
    
    func encodeHEX(_ uppercased: Bool = false) -> String {
        if uppercased == false {
            return self.map { String(format: "%02x", $0) }.joined()
        } else {
            return self.map { String(format: "%02X", $0) }.joined()
        }
    }
    

}

extension String {

    func decodeHEX() -> Data {
        var data = Data(capacity: self.count / 2)
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSRange(self.startIndex..., in: self)) { match, _, _ in
            let byteString = (self as NSString).substring(with: match!.range)
            let num = UInt8(byteString, radix: 16)!
            data.append(num)
        }
        return data
    }

}

