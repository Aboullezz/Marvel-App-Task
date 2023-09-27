//
//  MD5.swift
//  Marvel App
//
//  Created by Mohamed Aboullezz on 24/09/2023.
//

import Foundation
import CommonCrypto

//for Time Stamp.md5
extension String {
//    'md5' was deprecated in iOS 13.0
    @available(iOS, deprecated: 13.0)
    var md5: String {
        let data = Data(self.utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = data.withUnsafeBytes {
            CC_MD5($0.baseAddress, CC_LONG(data.count), &digest)
        }
        
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}

