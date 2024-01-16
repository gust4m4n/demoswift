import UIKit
import CommonCrypto

// https://md5decrypt.net/en/Xor/#results

extension Data {
    
    func encryptXOR(_ key: Data) -> Data {
        if self.count == 0 || key.count == 0 {
            return Data()
        }
        var encrypted = [UInt8]()
        let text = [UInt8](self.bytes)
        let kkk = [UInt8](key.bytes)
        let length = kkk.count
        for t in text.enumerated() {
            encrypted.append(t.element ^ kkk[t.offset % length])
        }
        return Data(bytes: encrypted, count: encrypted.count)
    }
    
    func decryptXOR(_ key: Data) -> Data {
        if self.count == 0 || key.count == 0 {
            return Data()
        }
        var decrypted = [UInt8]()
        let cypher = self
        let kkk = [UInt8](key.bytes)
        let length = kkk.count
        for c in cypher.enumerated() {
            decrypted.append(c.element ^ kkk[c.offset % length])
        }
        return Data(bytes: decrypted, count: decrypted.count)
    }
    
}
