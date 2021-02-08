//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation
import CommonCrypto

public typealias DigestAlgorithm = (UnsafeRawPointer?, CC_LONG, UnsafeMutablePointer<CUnsignedChar>?) -> UnsafeMutablePointer<CUnsignedChar>?

public enum CryptoAlgorithm {

    case md5, sha1, sha224, sha256, sha384, sha512

    public var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .md5:       result = kCCHmacAlgMD5
        case .sha1:      result = kCCHmacAlgSHA1
        case .sha224:    result = kCCHmacAlgSHA224
        case .sha256:    result = kCCHmacAlgSHA256
        case .sha384:    result = kCCHmacAlgSHA384
        case .sha512:    result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }

    public var digestAlgorithm: DigestAlgorithm {
        switch self {
        case .md5:      return CC_MD5
        case .sha1:     return CC_SHA1
        case .sha224:   return CC_SHA224
        case .sha256:   return CC_SHA256
        case .sha384:   return CC_SHA384
        case .sha512:   return CC_SHA512
        }
    }

    public var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .md5:       result = CC_MD5_DIGEST_LENGTH
        case .sha1:      result = CC_SHA1_DIGEST_LENGTH
        case .sha224:    result = CC_SHA224_DIGEST_LENGTH
        case .sha256:    result = CC_SHA256_DIGEST_LENGTH
        case .sha384:    result = CC_SHA384_DIGEST_LENGTH
        case .sha512:    result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

public extension String {

    // MARK: HMAC
    func HMAC(secret: String) -> Data {
        let keyStr    = secret.cString(using: String.Encoding.utf8)
        let str       = self.cString(using: String.Encoding.utf8)
        let keyLen    = Int(secret.lengthOfBytes(using: String.Encoding.utf8))
        let strLen    = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
        let result    = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), keyStr!, keyLen, str!, strLen, result)
        defer { result.deallocate() }
        return NSData(bytes: result, length: digestLen) as Data
    }

    private func hmacData(_ algorithm: CryptoAlgorithm, key: String) -> Data {
        let keyStr    = key.cString(using: String.Encoding.utf8)
        let str       = self.cString(using: String.Encoding.utf8)
        let keyLen    = Int(key.lengthOfBytes(using: String.Encoding.utf8))
        let strLen    = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result    = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)
        result.deallocate()
        return Data(bytes: UnsafePointer<UInt8>(result), count: digestLen)
    }

    private func hmac(_ algorithm: CryptoAlgorithm, key: String) -> String {
        let input = self
        let str = input.cString(using: String.Encoding.utf8)
        let strLen = Int(input.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))

        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)

        let digest = stringFromResult(result, length: digestLen)

        result.deallocate()

        return digest
    }

    // MARK: Digest
    var md5: String {
        digest(.md5)
    }

    var sha1: String {
        digest(.sha1)
    }

    var sha224: String {
        digest(.sha224)
    }

    var sha256: String {
        digest(.sha256)
    }

    var sha384: String {
        digest(.sha384)
    }

    var sha512: String {
        digest(.sha512)
    }

    func digest(_ algorithm: CryptoAlgorithm) -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)

        let _ = algorithm.digestAlgorithm(str!, strLen, result)

        let digest = stringFromResult(result, length: digestLen)

        result.deallocate()

        return digest
    }

    // MARK: Private
    fileprivate func stringFromResult(_ result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }

}

// MARK: - Encryption / Decryption
public extension String {

    /// Create `Data` from hexadecimal string representation
    ///
    /// This takes a hexadecimal representation and creates a `Data` object. Note, if the string has any spaces or non-hex characters (e.g. starts with '<' and with a '>'), those are ignored and only hex characters are processed.
    ///
    /// - returns: Data represented by this hexadecimal string.
    func hexadecimal() -> Data? {
        var data = Data(capacity: utf16.count / 2)

        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSMakeRange(0, utf16.count)) { match, flags, stop in
            let byteString = (self as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)!
            data.append(&num, count: 1)
        }

        guard data.count > 0 else { return nil }

        return data
    }

    func decryptedStringFromBase64String(hexKey: String, hexIV: String, keySize: Int, blockSize: Int, algorithm: CCAlgorithm, options: CCOptions) -> String? {
        let data = Data(base64Encoded: self)
        return data?.decrypt(hexKey: hexKey, hexIV: hexIV, keySize: keySize, blockSize: blockSize, algorithm: algorithm, options: options)
    }

}
