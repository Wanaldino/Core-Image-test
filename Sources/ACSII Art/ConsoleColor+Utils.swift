//
//  File.swift
//  
//
//  Created by Wanaldino Antimonio on 15/06/2020.
//

import ConsoleKit

extension ConsoleColor {
    init(with value: UInt32) {
        func B(_ x: UInt32) -> UInt8 {
            return UInt8((x & 0x00FF0000) >> 16)
        }
        func G(_ x: UInt32) -> UInt8 {
            return UInt8((x & 0x00FF00) >> 8)
        }
        func R(_ x: UInt32) -> UInt8 {
            return UInt8((x & 0xFF))
        }
        
        self = ConsoleColor.custom(r: R(value), g: G(value), b: B(value))
    }
}
