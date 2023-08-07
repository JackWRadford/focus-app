//
//  Formatters.swift
//  Focus
//
//  Created by Jack Radford on 07/08/2023.
//

import Foundation

/// Formats the given `date` in the short format
func formatDate(date: Date?) -> String {
    guard let date else {return "n.d."}
    
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    
    return formatter.string(from: date)
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
