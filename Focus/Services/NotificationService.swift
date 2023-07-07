//
//  NotificationService.swift
//  Focus
//
//  Created by Jack Radford on 07/07/2023.
//

import Foundation
import UserNotifications

/// Provides methods to schedule and cancel local notifications
struct NotificationService {
    
    /// Request notification permissions
    func requestPermissions() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notification Permissions Granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Schedule a notification for the given `date`. The notification content depends on the `stage`.
    func scheduleNotification(for date: Date, stage: TimerStage) {
        // Configure content
        let content = UNMutableNotificationContent()
        content.title = "Test"
        content.body = "This is a test notification."
        
        // Get the date components from the `date`
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // Schedule the request
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { error in
            if error != nil {
                // Handle errors
                print(error?.localizedDescription ?? "ERROR: NotificationService/scheduleNotification")
            }
        }
    }
    
    /// Cancel the notification with the given `uuidString`
    func cancelNotification(for uuidString: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [uuidString])
    }
}
