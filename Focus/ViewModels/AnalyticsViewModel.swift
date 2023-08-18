//
//  AnalyticsViewModel.swift
//  Focus
//
//  Created by Jack Radford on 16/08/2023.
//

import Foundation
import SwiftUI
import CoreData


class AnalyticsViewModel: ObservableObject {
    private let moc: NSManagedObjectContext
    private let persistenceService: PersistenceService
    /// The time period over which to show focus data for
    private var timeFrame: TimeFrame
    
    @Published var sessions: [Session] = []    
    
    /// The start and end dates of the `timeFrame`. (e.g. start of week and end of week)
    var timeFrameDates: (start: Date, end: Date) {
        // Calculate the start and end dates for the fetch request depending on the given `timeFrame`
        let now = Date()
        switch timeFrame {
        case .day:
            return (start: now.startOfDay, end: now.endOfDay)
        case .week:
            return  (start: now.startOfWeek, end: now.endOfWeek)
        case .month:
            return  (start: now.startOfMonth, end: now.endOfMonth)
        case .year:
            return  (start: now.startOfyear, end: now.endOfyear)
        }
    }
    
    init(timeFrame: TimeFrame, moc: NSManagedObjectContext) {
        self.moc = moc
        self.timeFrame = timeFrame
        self.persistenceService = PersistenceService(moc: moc)
        
        fetchSessions()
    }
    
    private func fetchSessions() {
        sessions = persistenceService.fetchSessions(from: timeFrameDates.start, to: timeFrameDates.end)
    }
    
    /// Get the longest session duration of a single session
    func bestSession() -> String {
        var bestDiff: TimeInterval = 0
        sessions.forEach { session in
            guard let start = session.startDate, var end = session.endDate else {return}
            // Make sure that time past the end of the timeFrame end is not included
            if end > timeFrameDates.end {
                end = timeFrameDates.end
            }
            let diff = end.timeIntervalSince1970 - start.timeIntervalSince1970
            if diff > bestDiff {
                bestDiff = diff
            }
        }
        return "\(timeStringFrom(diff: bestDiff, showUnits: true, allowedUnits: [.hour, .minute]))"
    }
    
    /// Get the chart label depending on the `timeFrame`
    func labelForTimeFrame() -> String {
        switch timeFrame {
        case .day:
            return "Today"
        case .week:
            return "This week"
        case .month:
            return "This month"
        case .year:
            return "This Year"
        }
    }
    
    /// Get the Chart's date unit depending on the `timeFrame`
    func unitForTimeFrame() -> Calendar.Component {
        switch timeFrame {
        case .day:
            return .hour
        case .week, .month:
            return .day
        case .year:
            return .month
        }
    }
    
    /// Sum the duration of all focus sessions
    func totalTime() -> String {
        let sum = sessions.reduce(0) {
            let endDate = $1.value(forKey: "endDate") as? Date
            let startDate = $1.value(forKey: "startDate") as? Date
            guard let startDate, let endDate else {return $0}
            let diff = endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970
            return $0 + diff
        }
        return "\(timeStringFrom(diff: sum, showUnits: true, allowedUnits: [.hour, .minute]))"
    }
    
    /// Returns the duration between the `startDate` and `endDate`
    func duration(from startDate: Date?, to endDate: Date?) -> String {
        guard let startDate, let endDate else {return ""}
        let diff = endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970
        return "\(timeStringFrom(diff: diff, showUnits: true, allowedUnits: [.hour, .minute]))"
    }
    
    /// Convert  `FetchedResults<Session>` data to `[FocusSession]` for the Chart.
    /// Always covers the `timeFrameDates` range.
    /// If the `timeFrame` is `.day` then the data is sorted into hours from 00:00 to 23:00
    func focusSessionData() -> [FocusSession] {
        let now = Date.now
        let calendar = Calendar.current
        var data: [FocusSession] = []
        // Convert
        sessions.forEach { session in
            guard let start = session.startDate, var end = session.endDate else { return }
            // Make sure that the session endDate is not after the timeFrame end
            if (end > timeFrameDates.end) {
                end = timeFrameDates.end
            }
            // Split data into hour segments for the .day timeFrame
            if timeFrame != .day {
                let date = start.startOfDay
                let duration = calendar.dateComponents([.minute], from: start, to: end).minute ?? 0
                data.append(.init(date: date, duration: duration))
            } else {
                let hourPointerComponents = calendar.dateComponents([.year, .month, .day, .hour], from: start)
                var hourPointerDate = calendar.date(from: hourPointerComponents) ?? now
                var fromDate = start
                while hourPointerDate < end {
                    // This date is the x-axis value
                    let date = hourPointerDate
                    // Iterate the hour pointer date by 1 hour
                    hourPointerDate = calendar.date(byAdding: .hour, value: 1, to: hourPointerDate) ?? now
                    // Use the end date if it is before the hour pointer date (before the end of the current hour)
                    let toDate = hourPointerDate < end ? hourPointerDate : end
                    let duration = calendar.dateComponents([.minute], from: fromDate, to: toDate).minute ?? 0
                    data.append(.init(date: date, duration: duration))
                    // Move the start date to the start of the next hour
                    fromDate = hourPointerDate
                }
            }
            
        }
        // Add start and end dates with duration 0 to make sure that the chart covers the desired range
        data.append(.init(date: timeFrameDates.start, duration: 0))
        data.append(.init(date: timeFrameDates.end, duration: 0))
        return data
    }
}

