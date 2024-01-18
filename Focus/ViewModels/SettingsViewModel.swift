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
    private let notificationService = NotificationService()
    
    // Timer lengths
    @AppStorage(UserDefaultsKey.focusDuration()) var focusDuration = "\(UDConstants.focusDuration)"
    @AppStorage(UserDefaultsKey.shortBreakDuration()) var shortBreakDuration = "\(UDConstants.shortBreakDuration)"
    @AppStorage(UserDefaultsKey.longBreakDuration()) var longBreakDuration = "\(UDConstants.longBreakDuration)"
    @AppStorage(UserDefaultsKey.breaksInterval()) var breaksInterval = "\(UDConstants.breaksInterval)"
    
    @AppStorage(UserDefaultsKey.notificationsEnabled()) var notificationsEnabled = true
    
    @Published var presentingNotificationsAlert = false
    
    // MARK: - Intents
    
    /// If  value is true schedule notifications, else  cancel all scheduled notifications.
    ///
    /// - Parameter value: A Bool dictating if the notifications should be scheduled or canceled.
    func handleNotificationsToggle(value: Bool) {
        if value {
            enableNotifications()
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
    
    // MARK: - Private functions
    
    /// If there is notification authorization, enable notifications, otherwise alert the user.
    private func enableNotifications() {
        Task {
            if await notificationService.hasAuthorization() == false {
                // Toggle off notifications enabled toggle
                notificationsEnabled = false
                // Alert user to update notification permissions
                presentingNotificationsAlert = true
            } else {
                notificationsEnabled = true
            }
        }
    }
}
