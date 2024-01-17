//
//  TimerStage.swift
//  Focus
//
//  Created by Jack Radford on 02/07/2023.
//

import Foundation

/// The stage of the pomodoro timer.
enum TimerStage: String {
    case focus,
         shortBreak,
         longBreak
    
    /// Provides a user facing string
    ///
    /// - Returns: String
    func getString() -> String {
        switch self {
        case .focus:
            return "Focus"
        case .shortBreak:
            return "Short Break"
        case.longBreak:
            return "Long Break"
        }
    }
}
