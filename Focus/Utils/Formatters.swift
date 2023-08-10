//
//  Formatters.swift
//  Focus
//
//  Created by Jack Radford on 07/08/2023.
//

import Foundation

/// Formats the given `date`
func formatDate(date: Date?) -> String {
    guard let date else {return "n.d."}
    return date.formatted(date: .numeric, time: .shortened)
}

/// Get formatted time string from a TimeInterval (a.k.a. Double) `diff`.
/// Format depends on `allowedUnits`.
/// Units are shown if `showUnits` is true
func timeStringFrom(diff: TimeInterval, showUnits: Bool, allowedUnits: NSCalendar.Unit) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = allowedUnits
    if showUnits {
        formatter.unitsStyle = .abbreviated
    }

    return formatter.string(from: diff) ?? ""
}
