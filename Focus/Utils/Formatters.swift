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

/// Get time formatted string from a TimeInterval (a.k.a. Double) `diff`
func timeStringFrom(diff: TimeInterval, showUnits: Bool) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    if showUnits {
        formatter.unitsStyle = .abbreviated
    }

    return formatter.string(from: diff) ?? ""
}
