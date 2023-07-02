//
//  SettingsViewModel.swift
//  Focus
//
//  Created by Jack Radford on 28/06/2023.
//

import Foundation
import SwiftUI

class SettingsViewModal: ObservableObject {
    // Timer length
    @AppStorage(UserDefaultsKey.focusDuration()) var focusDuration = "30"
    @AppStorage(UserDefaultsKey.shortBreakDuration()) var shortBreakDuration = "10"
    @AppStorage(UserDefaultsKey.longBreakDuration()) var longBreakDuration = "20"
    
    // Session
    @AppStorage(UserDefaultsKey.breaksInterval()) var breaksInterval = "2"
    @AppStorage(UserDefaultsKey.autoStartFocus()) var autoStartFocus = true
    @AppStorage(UserDefaultsKey.autoStartBreaks()) var autoStartBreaks = true
    
    // General
    @AppStorage(UserDefaultsKey.notificationsEnabled()) var notificationsEnabled = true
    @AppStorage(UserDefaultsKey.vibrateOnSilent()) var vibrateOnSilent = true
}
