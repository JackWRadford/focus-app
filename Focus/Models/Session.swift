//
//  Session.swift
//  Focus
//
//  Created by Jack Radford on 17/01/2024.
//

import Foundation

extension Session {
    var startDateString: String {
        startDate?.formatted(date: .numeric, time: .shortened) ?? "Unknown"
    }
    
    var endDateString: String {
        endDate?.formatted(date: .numeric, time: .shortened) ?? "Unknown"
    }
}
