//
//  SMUUID.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/18.
//

import Foundation

struct SMUUID {
    
    private(set) var uuidString: String

    init() {
        let len = 9
        var generator = SystemRandomNumberGenerator()
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

        let upperBound = UInt32(base.count)
        var randomString = ""

        for i in 0..<len {
            if i > 0 && i % 3 == 0 { randomString += "-" }
            let randomIndex = Int(generator.next(upperBound: upperBound))
            let randomCharacter = base[base.index(base.startIndex, offsetBy: randomIndex)]
            randomString.append(randomCharacter)
        }
        
        uuidString = randomString
    }
}
