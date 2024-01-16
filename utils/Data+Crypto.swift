import UIKit
import CommonCrypto

extension Data {
    
    func randomGenerateBytes(count: Int) -> Data? {
        let bytes = UnsafeMutableRawPointer.allocate(byteCount: count, alignment: 1)
        defer { bytes.deallocate() }
        let status = CCRandomGenerateBytes(bytes, count)
        guard status == kCCSuccess else { return nil }
        return Data(bytes: bytes, count: count)
    }
    
    func crypt128(operation: Int, algorithm: Int, options: Int, key: Data,
            iv: Data, dataIn: Data) -> Data? {
        return key.withUnsafeBytes { keyUnsafeRawBufferPointer in
            return dataIn.withUnsafeBytes { dataInUnsafeRawBufferPointer in
                return iv.withUnsafeBytes { ivUnsafeRawBufferPointer in
                    let dataOutSize: Int = dataIn.count + kCCBlockSizeAES128*2
                    let dataOut = UnsafeMutableRawPointer.allocate(byteCount: dataOutSize,
                        alignment: 1)
                    defer { dataOut.deallocate() }
                    var dataOutMoved: Int = 0
                    let status = CCCrypt(CCOperation(operation), CCAlgorithm(algorithm),
                        CCOptions(options),
                        keyUnsafeRawBufferPointer.baseAddress, key.count,
                        ivUnsafeRawBufferPointer.baseAddress,
                        dataInUnsafeRawBufferPointer.baseAddress, dataIn.count,
                        dataOut, dataOutSize, &dataOutMoved)
                    guard status == kCCSuccess else { return nil }
                    return Data(bytes: dataOut, count: dataOutMoved)
                }
            }
        }
    }
    
    func crypt256(operation: Int, algorithm: Int, options: Int, key: Data,
            iv: Data, dataIn: Data) -> Data? {
        return key.withUnsafeBytes { keyUnsafeRawBufferPointer in
            return dataIn.withUnsafeBytes { dataInUnsafeRawBufferPointer in
                return iv.withUnsafeBytes { ivUnsafeRawBufferPointer in
                    let dataOutSize: Int = dataIn.count + kCCBlockSizeAES128*2
                    let dataOut = UnsafeMutableRawPointer.allocate(byteCount: dataOutSize,
                        alignment: 1)
                    defer { dataOut.deallocate() }
                    var dataOutMoved: Int = 0
                    let status = CCCrypt(CCOperation(operation), CCAlgorithm(algorithm),
                        CCOptions(options),
                        keyUnsafeRawBufferPointer.baseAddress, key.count,
                        ivUnsafeRawBufferPointer.baseAddress,
                        dataInUnsafeRawBufferPointer.baseAddress, dataIn.count,
                        dataOut, dataOutSize, &dataOutMoved)
                    guard status == kCCSuccess else { return nil }
                    return Data(bytes: dataOut, count: dataOutMoved)
                }
            }
        }
    }
        
    func encryptAES128(key128: Data) -> Data? {
        guard let iv = randomGenerateBytes(count: kCCBlockSizeAES128) else { return nil }
        guard let ciphertext = crypt128(
            operation: kCCEncrypt,
            algorithm: kCCAlgorithmAES,
            options: kCCOptionPKCS7Padding,
            key: key128,
            iv: iv,
            dataIn: self) else { return nil }
        return iv + ciphertext
    }

    func decryptAES128(key128: Data) -> Data? {
        guard count > kCCBlockSizeAES128 else { return nil }
        let iv = prefix(kCCBlockSizeAES128)
        let ciphertext = suffix(from: kCCBlockSizeAES128)
        return crypt128(
            operation: kCCDecrypt,
            algorithm: kCCAlgorithmAES,
            options: kCCOptionPKCS7Padding,
            key: key128,
            iv: iv,
            dataIn: ciphertext)
    }
    
    func encryptAES256(key: Data, iv: Data) -> Data? {
        guard let ciphertext = crypt2(
            operation: kCCEncrypt,
            algorithm: kCCAlgorithmAES,
            options: kCCOptionPKCS7Padding,
            key: key,
            iv: iv,
            dataIn: self) else { return nil }
        return ciphertext
    }
    
    func decryptAES256(key: Data, iv: Data) -> Data? {
        guard let ciphertext = crypt2(
            operation: kCCDecrypt,
            algorithm: kCCAlgorithmAES,
            options: kCCOptionPKCS7Padding,
            key: key,
            iv: iv,
            dataIn: self) else { return nil }
        return ciphertext
    }

}
