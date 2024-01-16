import UIKit
import CommonCrypto

// http://ieasynote.com/tools/aes
// https://string-o-matic.com/aes-encrypt

extension Data {
        
    func encryptAES(_ key: Data, _ iv: Data) -> Data {
        let ciphertext = crypt(
            operation: kCCEncrypt,
            algorithm: kCCAlgorithmAES,
            options: kCCOptionPKCS7Padding,
            key: key,
            iv: iv,
            dataIn: self)
        return ciphertext
    }

    func decryptAES(_ key: Data, _ iv: Data) -> Data {
        let ciphertext = crypt(
            operation: kCCDecrypt,
            algorithm: kCCAlgorithmAES,
            options: kCCOptionPKCS7Padding,
            key: key,
            iv: iv,
            dataIn: self)
        return ciphertext
    }
    
    func crypt(operation: Int, algorithm: Int, options: Int, key: Data, iv: Data, dataIn: Data) -> Data {
        return key.withUnsafeBytes { keyUnsafeRawBufferPointer in
            return dataIn.withUnsafeBytes { dataInUnsafeRawBufferPointer in
                return iv.withUnsafeBytes { ivUnsafeRawBufferPointer in
                    let dataOutSize: Int = dataIn.count + kCCBlockSizeAES128*2
                    let dataOut = UnsafeMutableRawPointer.allocate(byteCount: dataOutSize,
                        alignment: 1)
                    defer { dataOut.deallocate() }
                    var dataOutMoved: Int = 0
                    let status = CCCrypt(CCOperation(operation),
                        CCAlgorithm(algorithm),
                        CCOptions(options),
                        keyUnsafeRawBufferPointer.baseAddress,
                        key.count,
                        ivUnsafeRawBufferPointer.baseAddress,
                        dataInUnsafeRawBufferPointer.baseAddress,
                        dataIn.count,
                        dataOut,
                        dataOutSize,
                        &dataOutMoved)
                    if (status == kCCSuccess) {
                        return Data(bytes: dataOut, count: dataOutMoved)
                    } else {
                        return Data()
                    }
                }
            }
        }
    }
    
    func crypt2(operation: Int, algorithm: Int, options: Int, key: Data, iv: Data, dataIn: Data) -> Data? {
        return key.withUnsafeBytes { keyUnsafeRawBufferPointer in
            return dataIn.withUnsafeBytes { dataInUnsafeRawBufferPointer in
                return iv.withUnsafeBytes { ivUnsafeRawBufferPointer in
                    let dataOutSize: Int = dataIn.count + kCCBlockSizeAES128*2
                    let dataOut = UnsafeMutableRawPointer.allocate(byteCount: dataOutSize,
                                                                   alignment: 1)
                    defer { dataOut.deallocate() }
                    var dataOutMoved: Int = 0
                    let status = CCCrypt(CCOperation(operation),
                                         CCAlgorithm(algorithm),
                                         CCOptions(options),
                                         keyUnsafeRawBufferPointer.baseAddress,
                                         key.count,
                                         ivUnsafeRawBufferPointer.baseAddress,
                                         dataInUnsafeRawBufferPointer.baseAddress,
                                         dataIn.count,
                                         dataOut,
                                         dataOutSize,
                                         &dataOutMoved)
                    guard status == kCCSuccess else { return nil }
                    return Data(bytes: dataOut, count: dataOutMoved)
                }
            }
        }
    }

}
