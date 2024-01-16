import UIKit

extension String {
    
    func doubleXorEncrypt(_ md5: String) -> String {
        let key1 = md5
        let key2 = key1.base64Encode().md5()
        let key3 = key2.xorEncrypt(key1).md5()
        let key4 = (key1 + key2 + key3).md5()
        return xorEncrypt((key4 + key3 + key2 + key1).md5())
    }

    func doubleXorDecrypt(_ md5: String) -> String {
        let key1 = md5
        let key2 = key1.base64Encode().md5()
        let key3 = key2.xorEncrypt(key1).md5()
        let key4 = (key1 + key2 + key3).md5()
        return xorDecrypt((key4 + key3 + key2 + key1).md5())
    }

    func doubleEncrypt(_ md5: String) -> String {
        let key1 = md5
        let key2 = key1.base64Encode().md5()
        let key3 = key2.xorEncrypt(key1).md5()
        let key4 = (key1 + key2 + key3).md5()
        let cipher1 = self.xorEncrypt((key1 + key2 + key3 + key4).md5())
        return cipher1.encryptAES128(key128: (key4 + key3 + key2 + key1).md5())
    }

    func doubleDecrypt(_ md5: String) -> String {
        let key1 = md5
        let key2 = key1.base64Encode().md5()
        let key3 = key2.xorEncrypt(key1).md5()
        let key4 = (key1 + key2 + key3).md5()
        let cipher1 = self.decryptAES128(key128: (key4 + key3 + key2 + key1).md5())
        return cipher1.xorDecrypt((key1 + key2 + key3 + key4).md5())
    }
    
}
