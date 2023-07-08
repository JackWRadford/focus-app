//
//  SettingsViewModel.swift
//  Focus
//
//  Created by Jack Radford on 28/06/2023.
//

import Foundation
import SwiftUI

@MainActor
class SettingsViewModal: ObservableObject {
    // Timer length
    @AppStorage(UserDefaultsKey.focusDuration()) var focusDuration = "\(UDConstants.focusDuration)"
    @AppStorage(UserDefaultsKey.shortBreakDuration()) var shortBreakDuration = "\(UDConstants.shortBreakDuration)"
    @AppStorage(UserDefaultsKey.longBreakDuration()) var longBreakDuration = "\(UDConstants.longBreakDuration)"
    @AppStorage(UserDefaultsKey.breaksInterval()) var breaksInterval = "\(UDConstants.breaksInterval)"
    
    // General
    @AppStorage(UserDefaultsKey.notificationsEnabled()) var notificationsEnabled = true
    
    @Published var presentingNotificationsAlert = false
    
    /// If  `value` is true  schedule notifications, else  cancel all scheduled notifications
    func handleNotificationsToggle(value: Bool) {
        let notificationService = NotificationService()
        if value {
            Task {
                if await !notificationService.hasAuthorization() {
                    // Toggle off notifications enabled toggle
                    notificationsEnabled = false
                    // Alert user to update notification permissions
                    presentingNotificationsAlert = true
                } else {
                    // Schedule notifications for the active countdown if there is one
                }
            }
        } else {
            notificationService.cancelAll()
        }
    }
    
    /// Deep link to the app's custom settings in the iOS settings
    func openDeviceSettings() {
        // Create the URL that deep links to your app's custom settings.
        if let url = URL(string: UIApplication.openSettingsURLString) {
            // Ask the system to open that URL.
            UIApplication.shared.open(url)
        }
    }
}
