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
    
    @AppStorage(UserDefaultsKey.notificationsEnabled()) var notificationsEnabled = UDConstants.notificationsEnabled
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    /// Check for notification authorization
    /// - Returns: Bool
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
    
    /// Schedule a notification for the specific date and time.
    /// - Parameters:
    ///   - date: The Date for which to schedule a notification.
    ///   - title: The title String for the notification.
    ///   - body: The body String for the notification.
    func scheduleNotification(for date: Date, title: String, body: String) {
        // Only schedule notifications if they are enabled
        guard notificationsEnabled else { return }
        
        // Configure content
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
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
