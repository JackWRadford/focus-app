//
//  CountdownViewModel.swift
//  Focus
//
//  Created by Jack Radford on 27/06/2023.
//

import Foundation
import SwiftUI

@MainActor
class CountdownViewModel: ObservableObject {
    
    let notificationService = NotificationService()
    
    // UserDefaults timer values
    @AppStorage(UserDefaultsKey.endDate()) var endDate = Date().timeIntervalSince1970
    @AppStorage(UserDefaultsKey.durationRemaining()) var durationRemaining = 0.0
    @AppStorage(UserDefaultsKey.isActive()) var isActive = false
    @AppStorage(UserDefaultsKey.isPaused()) var isPaused = false
    @AppStorage(UserDefaultsKey.timerStage()) var timerStage = TimerStage.focus.rawValue
    @AppStorage(UserDefaultsKey.breaksInterval()) var breaksInterval = UDConstants.breaksInterval
    @AppStorage(UserDefaultsKey.focusStagesDone()) var focusStagesDone = UDConstants.focusStagesDone
    @AppStorage(UserDefaultsKey.focusDuration()) var focusDuration = UDConstants.focusDuration
    @AppStorage(UserDefaultsKey.shortBreakDuration()) var shortBreakDuration = UDConstants.shortBreakDuration
    @AppStorage(UserDefaultsKey.longBreakDuration()) var longBreakDuration = UDConstants.longBreakDuration
    
    /// Used to show the active coutndown value
    @Published var timeDiff: Double? = nil
    
    /// If the pomodoro session has started
    var sessionStarted: Bool {
        isActive || focusStagesDone > 0
    }
    
    /// The `timerStage` as a TimerStage enum value
    var stage: TimerStage {
        get {
            TimerStage(rawValue: timerStage) ?? TimerStage.focus
        }
        set {
            // timerStage is stored as a String in UserDefaults
            timerStage = newValue.rawValue
        }
    }
    
    /// The string showing time remaining
    var time: String {
        if let timeDiff {
            return timeStringFrom(diff: timeDiff)
        } else {
            return "\(startMinutes):00"
        }
    }
    
    /// The initial duration of the countdown
    var startMinutes: Int {
        switch stage {
        case .focus:
            return focusDuration
        case .shortBreak:
            return shortBreakDuration
        case .longBreak:
            return longBreakDuration
        }
    }
    
    /// Label for the main countdown button
    var actionLabel: String {
        return isActive ?
        (isPaused ? "Resume" : "Pause"): (stage == .focus ? "Focus" : "Start")
    }
    
    init() {
        // Request notification permissions
        notificationService.requestPermissions()
        
        if (isActive) {
            if (isPaused) {
                timeDiff = durationRemaining
            } else {
                updateCountdown()
            }
        }
    }
    
    /// Get `time` formatted string from a TimeInterval (a.k.a. Double) `diff`
    private func timeStringFrom(diff: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: diff)
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    /// Start, resume or pause the countdown depending on `isActive` and `isPaused`
    func handleAction() {
        if (isActive) {
            isPaused ? resume() : pause()
        } else {
            start()
        }
    }
    
    /// Start the  countdown. Sets the `endDate`
    func start() {
        isActive = true
        let now = Date()
        
        // Store Date for use when scheduling the notification
        let endDateObj = Calendar.current.date(byAdding: .minute, value: startMinutes, to: now)!
        endDate = endDateObj.timeIntervalSince1970
        
        // Schedule the notification
        notificationService.scheduleNotification(for: endDateObj, stage: stage)
    }
    
    /// Pause the countdown. Sets the `durationRemaining`
    func pause() {
        isPaused = true
        let now = Date()
        let diff = endDate - now.timeIntervalSince1970
        durationRemaining = diff
        
        // Cancel notifications
        notificationService.cancelAll()
    }
    
    /// Resume the countdown. Sets the new `endDate` from the `durationRemaining`.
    func resume() {
        isPaused = false
        let now = Date()
        
        // Round durationRemaining up before converting to Int to avoid skipping a second when resuming
        let endDateObj = Calendar.current.date(byAdding: .second, value: Int(durationRemaining.rounded(.up)), to: now)!
        endDate = endDateObj.timeIntervalSince1970
        
        // Schedule the notification
        notificationService.scheduleNotification(for: endDateObj, stage: stage)
    }
    
    /// Reset the countdown.
    func reset() {
        isActive = false
        isPaused = false
        timeDiff = nil
        focusStagesDone = 0
        stage = .focus
        
        // Cancel notifications
        notificationService.cancelAll()
    }
    
    /// Go to the next (`stage`).
    func nextStage() {
        // Update stage
        switch stage {
        case .focus:
            focusStagesDone += 1
            stage = focusStagesDone < breaksInterval ? .shortBreak : .longBreak
        case .shortBreak:
            stage = .focus
        case .longBreak:
            focusStagesDone = 0
            stage = .focus
        }
        // Update timer
        isActive = false
        isPaused = false
        timeDiff = nil
        
        // Cancel notifications
        notificationService.cancelAll()
    }
    
    /// Calculates the `timeDiff` (The TimeInterval between now and the `endDate`).
    func updateCountdown() {
        guard isActive && !isPaused else { return }
        
        let now = Date()
        let diff = endDate - now.timeIntervalSince1970
        
        // If the countdown is done, go to the next stage
        if diff <= 0 {
            nextStage()
            return
        }
        
        timeDiff = diff
    }
}
