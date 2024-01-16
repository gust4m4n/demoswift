import UIKit
import CommonCrypto

extension String {

    func decodeBase64() -> Data {
        if let data = Data(base64Encoded: self) {
            return data
        } else {
            return Data()
        }
    }
        
}

extension Data {
    
    func encodeBase64() -> String {
        return self.base64EncodedString()
    }
    
}
