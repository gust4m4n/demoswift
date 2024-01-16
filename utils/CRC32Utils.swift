import UIKit
import CryptoSwift

extension Data {
        
    func crc() -> String {
        let value = string().crc32()
        return value
    }

}
