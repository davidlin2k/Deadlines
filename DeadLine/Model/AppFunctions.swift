//
//  AppEngine.swift
//  DeadLine
//
//  Created by David Lin on 2022-09-22.
//

import Foundation

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
