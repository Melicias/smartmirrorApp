//
//  Encrypt.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 28/10/2022.
//

import Foundation
import CommonCrypto

struct Encrypt {
    private let key: Data = "1234567890123456".data(using: .utf8)!
    private let iv: Data = "abcdefghijklmnop".data(using: .utf8)!

    func encrypt(string: String) -> Data? {
        return crypt(data: string.data(using: .utf8), option: CCOperation(kCCEncrypt))
    }

    func decrypt(data: Data?) -> String? {
        guard let decryptedData = crypt(data: data, option: CCOperation(kCCDecrypt)) else { return nil }
        return String(bytes: decryptedData, encoding: .utf8)
    }

    func crypt(data: Data?, option: CCOperation) -> Data? {
        guard let data = data else { return nil }
    
        let cryptLength = data.count + key.count
        var cryptData   = Data(count: cryptLength)
    
        var bytesLength = Int(0)
    
        let status = cryptData.withUnsafeMutableBytes { cryptBytes in
            data.withUnsafeBytes { dataBytes in
                iv.withUnsafeBytes { ivBytes in
                    key.withUnsafeBytes { keyBytes in
                    CCCrypt(option, CCAlgorithm(kCCAlgorithmAES), CCOptions(kCCOptionPKCS7Padding), keyBytes.baseAddress, key.count, ivBytes.baseAddress, dataBytes.baseAddress, data.count, cryptBytes.baseAddress, cryptLength, &bytesLength)
                    }
                }
            }
        }
    
        guard Int32(status) == Int32(kCCSuccess) else {
            debugPrint("Error: Failed to crypt data. Status \(status)")
            return nil
        }
    
        cryptData.removeSubrange(bytesLength..<cryptData.count)
        return cryptData
    }
}
