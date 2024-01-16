import UIKit
import CryptoKit

enum HMACAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    
    func toCCHmacAlgorithm() -> CCHmacAlgorithm {
        var result: Int = 0
        switch self {
            case .MD5:
                result = kCCHmacAlgMD5
            case .SHA1:
                result = kCCHmacAlgSHA1
            case .SHA224:
                result = kCCHmacAlgSHA224
            case .SHA256:
                result = kCCHmacAlgSHA256
            case .SHA384:
                result = kCCHmacAlgSHA384
            case .SHA512:
                result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    
    func digestLength() -> Int {
        var result: CInt = 0
        switch self {
            case .MD5:
                result = CC_MD5_DIGEST_LENGTH
            case .SHA1:
                result = CC_SHA1_DIGEST_LENGTH
            case .SHA224:
                result = CC_SHA224_DIGEST_LENGTH
            case .SHA256:
                result = CC_SHA256_DIGEST_LENGTH
            case .SHA384:
                result = CC_SHA384_DIGEST_LENGTH
            case .SHA512:
                result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

extension String {
    
    func base64Encode() -> String {
        let data = self.data(using: .utf8)
        return data!.base64EncodedString()
    }
    
    func base64Decode() -> String {
        if let data = Data(base64Encoded: self) {
            if let value = String(data: data, encoding: .utf8) {
                return value
            } else {
                return ""
            }
        } else {
            return ""
        }
    }

    func md5() -> String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
    func sha256() -> String {
        let data = Data(self.utf8)
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
    
    func xorEncrypt(_ md5: String) -> String {
        if self.count == 0 || md5.count == 0 {
            return ""
        }
        var encrypted = [UInt8]()
        let text = [UInt8](self.utf8)
        let key = [UInt8](md5.utf8)
        let length = key.count
        for t in text.enumerated() {
            encrypted.append(t.element ^ key[t.offset % length])
        }
        if let str = String(bytes: encrypted, encoding: .utf8) {
            return str.base64Encode()
        } else {
            return ""
        }
    }

    func xorDecrypt(_ md5: String) -> String {
        if self.count == 0 || md5.count == 0 {
            return ""
        }
        if let cypherText = Data(base64Encoded: self) {
            var decrypted = [UInt8]()
            let cypher = cypherText
            let key = [UInt8](md5.utf8)
            let length = key.count
            for c in cypher.enumerated() {
                decrypted.append(c.element ^ key[c.offset % length])
            }
            if let str = String(bytes: decrypted, encoding: .utf8) {
                return str
            } else {
                return ""
            }
        } else {
            return ""
        }
    }
    
    func encryptAES128(key128: String) -> String {
        if let key = key128.data(using: .utf8) {
            if let plain = self.data(using: .utf8) {
                if let data = plain.encryptAES128(key128: key) {
                    return data.base64EncodedString()
                }
            }
        }
        return ""
    }

    func decryptAES128(key128: String) -> String {
        if let key = key128.data(using: .utf8) {
            if let plain = Data(base64Encoded: self) {
                if let data = plain.decryptAES128(key128: key) {
                    if let value = String(data: data, encoding: .utf8) {
                        return value
                    }
                }
            }
        }
        return ""
    }
    
    func encryptAES256(_ key: String, _ iv: String) -> String {
        let password = key.dataUInt8()
        if let theiv = iv.data(using: .utf8, allowLossyConversion: false) {
            if let plain = self.data(using: .utf8, allowLossyConversion: false) {
                if let data = plain.encryptAES256(key: password, iv: theiv) {
                    return data.base64EncodedString()
                }
            }
        }
        return ""
    }
    
    func decryptAES256(_ key: String, _ iv: String) -> String {
        if let decodedData = Data(base64Encoded: self) {
            let password = key.dataUInt8()
            if let theiv = iv.data(using: .utf8) {
                if let data = decodedData.decryptAES256(key: password, iv: theiv) {
                    if let value = String(data: data, encoding: .utf8) {
                        return value
                    }
                }
            }
        }
        return ""
    }
    
    func hmac(algorithm: HMACAlgorithm, key: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), key, key.count, self, self.count, &digest)
        let data = Data(bytes: digest)
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    } 
    
        
}
