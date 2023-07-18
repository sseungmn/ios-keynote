//
//  SMUUID.swift
//  MyKeynote
//
//  Created by SEUNGMIN OH on 2023/07/18.
//

import Foundation

/// 9자리 고유한 문자열
///
/// * uuid는 5bytes의 크기를 갖음.
///
/// ### 주의
/// * 12^9 = 6.8e10의 경우의 수가 있음.
/// 따라서, **1/6.8e10**의 확률로 충돌이 일어날 수 있음.
///
struct SMUUID: Hashable {

    private(set) var uuid: Data

    init() {
        let length: Double = 9
        var generator = SystemRandomNumberGenerator()

        var bitSequence = Data()
        for _ in 0..<Int(ceil(length/2)) {
            bitSequence.append(UInt8.random(in: 0..<UInt8.max, using: &generator))
        }
        self.uuid = bitSequence
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
