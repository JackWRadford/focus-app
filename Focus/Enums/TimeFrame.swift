//
//  TimeFrame.swift
//  Focus
//
//  Created by Jack Radford on 09/08/2023.
//

import Foundation

enum TimeFrame: String, CaseIterable, Identifiable {
    case day, week, month, year
    var id: Self { self }
}
