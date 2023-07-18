//
//  SMUUID.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/18.
//

import Foundation

struct SMUUID {
    
    private(set) var uuid: Data

    // uuidString: 9bytes 문자열
    // uuid: 4bytes bitSequence
    init() {
        let len = 9
        var generator = SystemRandomNumberGenerator()

        var bitSequence = Data()
        for index in 0..<Int(ceil(Double(len)/2)) {
            bitSequence.append(UInt8.random(in: 0..<UInt8.max, using: &generator))
        }
        uuid = bitSequence
//        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//
//        let upperBound = UInt32(base.count)
//        var randomString = ""
//
//        for i in 0..<len {
//            let randomIndex = Int(generator.next(upperBound: upperBound))
//            let randomCharacter = base[base.index(base.startIndex, offsetBy: randomIndex)]
//            randomString.append(randomCharacter)
//        }
//        
//        uuid = randomString
    }
}

extension SMUUID: CustomStringConvertible {
    var description: String {
        return "\(String(format: "%03X", UInt32(uuid[0]) << 4 | UInt32(uuid[1]) >> 4))"
            + "-"
            + "\(String(format: "%03X", (UInt32(uuid[1]) & 0xF) << 8 | UInt32(uuid[2])))"
            + "-"
            + "\(String(format: "%03X", UInt32(uuid[3]) << 4 | UInt32(uuid[4]) >> 4))"
    }
}
