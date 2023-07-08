//
//  UserDefaultsKey.swift
//  Focus
//
//  Created by Jack Radford on 01/07/2023.
//

import Foundation

/// Keys used for UserDefaults. Call as a function to get the String rawValue
///
/// **DO NOT CHANGE VALUES**
enum UserDefaultsKey: String {
    case breaksInterval, notificationsEnabled, longBreakDuration,
         shortBreakDuration, focusDuration, endDate,
         isPaused, durationRemaining, timerStage,
         isActive, focusStagesDone, notificationPermissionsRequested
    
    /// Return the rawValue when called as a function
    ///
    /// Avoids needing `.rawValue`
    func callAsFunction() -> String {
        return self.rawValue
    }
}
