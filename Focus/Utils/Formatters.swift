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
func timeStringFrom(diff: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: diff)
    let calendar = Calendar.current
    let minutes = calendar.component(.minute, from: date)
    let seconds = calendar.component(.second, from: date)
    
    return String(format: "%d:%02d", minutes, seconds)
}
