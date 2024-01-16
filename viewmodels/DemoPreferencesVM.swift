import Foundation
import KeychainSwift

class DemoPreferencesVM {
    static func encodeKey(_ key: String) -> String {
        return key.data().encryptXOR(DemoSecurityVM.generateEncryptionKey()).encodeBase64()
    }

    static func set(value: String, forKey: String) {
        let keychain = KeychainSwift()
        keychain.set(value.data().encryptDouble().encodeBase64(), forKey: encodeKey(forKey))
    }

    static func get(forKey: String) -> String {
        let keychain = KeychainSwift()
        if let value = keychain.get(encodeKey(forKey)) {
            return value.decodeBase64().decryptDouble().string()
        }
        return ""
    }

    static func set(value: Bool, forKey: String) {
        set(value: String(value), forKey: forKey)
    }

    static func get(forKey: String) -> Bool {
        return Bool(get(forKey: forKey)) ?? false
    }

    static func set(value: Int64, forKey: String) {
        set(value: String(value), forKey: forKey)
    }

    static func get(forKey: String) -> Int64 {
        return Int64(get(forKey: forKey)) ?? 0
    }
    
    static func setUnsecure(value: String, forKey: String) {
        UserDefaults.standard.set(value.data().encryptDouble().encodeBase64(), forKey: encodeKey(forKey))
        UserDefaults.standard.synchronize()
    }

    static func getUnsecure(forKey: String) -> String {
        if let value = UserDefaults.standard.string(forKey: encodeKey(forKey)) {
            return value.decodeBase64().decryptDouble().string()
        }
        return ""
    }
    
    static func setUnsecure(value: Bool, forKey: String) {
        setUnsecure(value: String(value), forKey: forKey)
    }

    static func getUnsecure(forKey: String) -> Bool {
        return Bool(getUnsecure(forKey: forKey)) ?? false
    }

    static func setFreshInstall(_ value: Bool) {
        var flag = false
        if value == false {
            flag = true
        } else {
            flag = false
        }
        setUnsecure(value: flag, forKey: "f2ed9d571c7d13985ebf58066bb145d22e1a299c22bb38ae99aae5feebcb4f9d")
    }

    static func getFreshInstall() -> Bool {
        let value = getUnsecure(forKey: "f2ed9d571c7d13985ebf58066bb145d22e1a299c22bb38ae99aae5feebcb4f9d") as Bool
        if value == false {
            return true
        } else {
            return false
        }
    }
    
    static func setDeviceId(_ value: String) {
        set(value: value, forKey: "467cf826963d56f8b882c63b79c04dc81f7ee7ad7a06dea90a2ecdacd9fdaf84")
    }
    
    static func getDeviceId() -> String {
        let deviceId = get(forKey: "467cf826963d56f8b882c63b79c04dc81f7ee7ad7a06dea90a2ecdacd9fdaf84") as String
        return deviceId
    }
    
    static func setAccessToken(_ value: String) {
        set(value: value, forKey: "230ab146dbde5eb4625864c2f7f9c5281f912437dcf42e820cea6e15a3076379")
    }
    
    static func getAccessToken() -> String{
        return get(forKey: "230ab146dbde5eb4625864c2f7f9c5281f912437dcf42e820cea6e15a3076379")
    }
    
    static func resetAll() {
        setAccessToken("")
    }
    
    static func resetAllAndFresh() {
        DemoPreferencesVM.resetAll()
        DemoPreferencesVM.setFreshInstall(true)
    }
    
}

