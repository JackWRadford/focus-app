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
    @AppStorage(UserDefaultsKey.focusDuration()) var focusDuration = "\(UDConstants.focusDuration)"
    @AppStorage(UserDefaultsKey.shortBreakDuration()) var shortBreakDuration = "\(UDConstants.shortBreakDuration)"
    @AppStorage(UserDefaultsKey.longBreakDuration()) var longBreakDuration = "\(UDConstants.longBreakDuration)"
    
    // Session
    @AppStorage(UserDefaultsKey.breaksInterval()) var breaksInterval = "\(UDConstants.breaksInterval)"
    @AppStorage(UserDefaultsKey.autoStartFocus()) var autoStartFocus = true
    @AppStorage(UserDefaultsKey.autoStartBreaks()) var autoStartBreaks = true
    
    // General
    @AppStorage(UserDefaultsKey.notificationsEnabled()) var notificationsEnabled = true
    @AppStorage(UserDefaultsKey.vibrateOnSilent()) var vibrateOnSilent = true
}
