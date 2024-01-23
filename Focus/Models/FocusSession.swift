//
//  FocusSession.swift
//  Focus
//
//  Created by Jack Radford on 23/01/2024.
//

import Foundation

/// Used for the focus time bar chart.
struct FocusSession: Identifiable {
    var date: Date
    var duration: Int
    var id = UUID()
}

extension FocusSession {
    
    /// Test data.
    ///
    /// - Returns: An array of FocusSessions.
    static func randomTestData() -> [FocusSession] {
        var data: [FocusSession] = []
        (0..<7).forEach { index in
            let date = Calendar.current.date(byAdding: .day, value: -1 * index, to: .now) ?? Date()
            let duration = Int.random(in: 0..<121)
            data.append(.init(date: date, duration: duration))
        }
        return data
    }
}
