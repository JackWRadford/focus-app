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
