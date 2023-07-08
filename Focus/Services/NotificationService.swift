//
//  NotificationService.swift
//  Focus
//
//  Created by Jack Radford on 07/07/2023.
//

import Foundation
import UserNotifications
import SwiftUI

/// Provides methods to schedule and cancel local notifications
struct NotificationService {
    
    @AppStorage(UserDefaultsKey.notificationsEnabled()) var notificationsEnabled = true
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    /// Check for notification authorization
    func hasAuthorization() async -> Bool {
        var permissionsGranted = false
        let settings = await notificationCenter.notificationSettings()
        permissionsGranted = ((settings.authorizationStatus == .authorized) || (settings.authorizationStatus == .provisional))
        return permissionsGranted
    }
    
    /// Request notification permissions and update UserDefaults value to show that permissions have been requested
    func requestPermissions() {
        // Set UserDefaults notificationPermissionsRequested to true
        UserDefaults.standard.set(true, forKey: UserDefaultsKey.notificationPermissionsRequested())
        // Request authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Schedule a notification for the given `date`. The notification content depends on the `stage`.
    func scheduleNotification(for date: Date, stage: TimerStage) {
        // Only schedule notifications if they are enabled
        guard notificationsEnabled else { return }
        
        // Configure content
        let content = UNMutableNotificationContent()
        content.title = "Countdown done!"
        content.body = "This is a test notification."
        
        // Get the date components from the `date`
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // Schedule the request
        notificationCenter.add(request) { error in
            if error != nil {
                // Handle errors
                print(error?.localizedDescription ?? "ERROR: NotificationService/scheduleNotification")
            }
        }
    }
    
    /// Cancel all scheduled notifications
    func cancelAll() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
}
