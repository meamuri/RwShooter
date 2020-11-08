//
//  PhysicalCategory.swift
//  RwShooter
//
//  Created by Roman Dronov on 08.11.2020.
//

import Foundation

class PhysicalCategory {
    static let none : UInt32 = 0
    static let all : UInt32 = UInt32.max
    static let monster : UInt32 = 0b1
    static let projectile : UInt32 = 0b10
}
