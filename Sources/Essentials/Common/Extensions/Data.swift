//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation
import CommonCrypto

public extension Data {

    /// Create hexadecimal string representation of `Data` object.
    ///
    /// - returns: `String` representation of this `Data` object.
    func hexadecimal() -> String {
        map { String(format: "%02x", $0) }.joined(separator: "")
    }

    private func crypt(keyData: Data, ivData: Data, operation: CCOperation, keySize: Int, blockSize: Int, algorithm: CCAlgorithm, options: CCOptions) -> Data {
        let cryptLength = size_t(self.count + blockSize)
        var cryptData = Data(count: cryptLength)

        var numBytesEncrypted: size_t = 0

        let cryptStatus: CCCryptorStatus = cryptData.withUnsafeMutableBytes { cryptBytes in
            self.withUnsafeBytes { dataBytes in
                ivData.withUnsafeBytes { ivBytes in
                    keyData.withUnsafeBytes { keyBytes in
                        CCCrypt(operation,
                                algorithm,
                                options,
                                keyBytes.baseAddress, keySize,
                                ivBytes.baseAddress,
                                dataBytes.baseAddress, self.count,
                                cryptBytes.baseAddress, cryptLength,
                                &numBytesEncrypted)
                    }
                }
            }
        }

        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.removeSubrange(numBytesEncrypted..<cryptData.count)
        } else {
            debugPrint("\(cryptStatus)")
        }

        return cryptData
    }

    /// Encrypt a piece of Data
    /// - Parameters:
    ///   - keyData: Raw key material
    ///   - ivData: The initialization vector for the encryption
    ///   - keySize: The size of the key
    ///   - blockSize: The block size
    ///   - algorithm: The encryption algorithm
    ///   - options:  A word of flags defining options. See discussion for the CCOptions type.
    /// - Returns: The encrypted data
    func encrypt(keyData: Data, ivData: Data, keySize: Int, blockSize: Int, algorithm: CCAlgorithm, options: CCOptions) -> Data {
        crypt(keyData: keyData, ivData: ivData, operation: CCOperation(kCCEncrypt), keySize: keySize, blockSize: blockSize, algorithm: algorithm, options: options)
    }

    func decrypt(hexKey key: String, hexIV iv: String, keySize: Int, blockSize: Int, algorithm: CCAlgorithm, options: CCOptions) -> String? {
        guard
            let keyData = key.hexadecimal(),
            let ivData  = iv.hexadecimal()
        else { return nil }
        let result = crypt(keyData: keyData,
                           ivData: ivData,
                           operation: CCOperation(kCCDecrypt),
                           keySize: keySize,
                           blockSize: blockSize,
                           algorithm: algorithm,
                           options: options)
        return String(data: result, encoding: .utf8)
    }

}
