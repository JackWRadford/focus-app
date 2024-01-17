//
//  Session.swift
//  Focus
//
//  Created by Jack Radford on 17/01/2024.
//

import Foundation

extension Session {
    var startDateString: String {
        userFacingString(for: startDate)
    }
    
    var endDateString: String {
        userFacingString(for: endDate)
    }
    
    // MARK: - Functions
    private func userFacingString(for date: Date?) -> String {
        return date?.formatted(date: .numeric, time: .shortened) ?? "Unknown"
    }
}
