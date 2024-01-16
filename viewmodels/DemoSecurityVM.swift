import UIKit

class DemoSecurityVM {
    static let securityKey = "cce7f2201a55a954c167d12b8712ac63730f6056a752d6b7b68d065f74af6bf4"
    
    static func generateEncryptionKey() -> Data {
        var key = String(securityKey.reversed())
        let crc = key.data().crc()
        key = key.data().encryptXOR(crc.data()).string()
        return key.data().sha()
    }
    
    static func generateEncryptionIV() -> Data {
        var iv = String(securityKey.reversed())
        iv = iv.data().encryptXOR(iv.data().crc().data()).encodeHEX()
        iv = String(iv.prefix(32))
        return iv.decodeHEX()
    }
    
    static func generateDeviceId() -> String {
        var vendorId = ""
        if let vendorUuid = UIDevice.current.identifierForVendor?.uuidString {
            vendorId = vendorUuid
        }
        let uuidRef: CFUUID = CFUUIDCreate(nil)
        let uuidStringRef: CFString = CFUUIDCreateString(nil, uuidRef)
        let uniqueId = "\(vendorId)\(uuidStringRef as String)"
        return uniqueId.replacingOccurrences(of: "-", with: "").lowercased()
    }

}

extension Data {
            
    func encryptDouble() -> Data {
        return self.encryptAES(DemoSecurityVM.generateEncryptionKey(), DemoSecurityVM.generateEncryptionIV())
    }

    func decryptDouble() -> Data {
        return self.decryptAES(DemoSecurityVM.generateEncryptionKey(), DemoSecurityVM.generateEncryptionIV())
    }

}

