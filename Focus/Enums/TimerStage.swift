//
//  TimerStage.swift
//  Focus
//
//  Created by Jack Radford on 02/07/2023.
//

import Foundation

/// Stage of the pomodoro timer
///
/// **DO NOT CHANGE VALUES**
enum TimerStage: String {
    case focus,
         shortBreak,
         longBreak
    
    /// Provides a user facing string
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
