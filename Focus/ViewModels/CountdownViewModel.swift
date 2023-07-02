//
//  CountdownViewModel.swift
//  Focus
//
//  Created by Jack Radford on 27/06/2023.
//

import Foundation

class CountdownViewModel: ObservableObject {    
    @Published var isActive = false
    @Published var time: String = "5:00"
    @Published var minutes: Float = 5.0 {
        // Update time when minutes is changed
        didSet {
            time = "\(Int(minutes)):00"
        }
    }
    
    private var initialTime = 0
    private var endDate = Date()
    
    /// Start the pomodoro timer
    func start(minutes: Float) {
        initialTime = Int(minutes)
        endDate = Date()
        endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
        isActive = true
    }
    
    func reset() {
        minutes = Float(initialTime)
        isActive = false
    }
    
    func updateCountdown() {
        guard isActive else { return }
        
        let now = Date()
        let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
        
        if diff <= 0 {
            isActive = false
            time = "0:00"            
            return
        }
        
        let date = Date(timeIntervalSince1970: diff)
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        self.minutes = Float(minutes)
        time = String(format: "%d:%02d", minutes, seconds)
    }
}
