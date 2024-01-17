//
//  Formatters.swift
//  Focus
//
//  Created by Jack Radford on 07/08/2023.
//

import Foundation

/// Get formatted time string from a TimeInterval
///
/// - Parameters:
///   - diff: Time Interval.
///   - showUnits: Bool dictating if units should be shown or not.
///   - allowedUnits: For the DateComponentsFormatter
/// - Returns: A formatted time String.
func timeStringFrom(diff: TimeInterval, showUnits: Bool, allowedUnits: NSCalendar.Unit) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = allowedUnits
    if showUnits {
        formatter.unitsStyle = .abbreviated
    }
    
    return formatter.string(from: diff) ?? ""
}
