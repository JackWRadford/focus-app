//
//  AnalyticsBodyView.swift
//  Focus
//
//  Created by Jack Radford on 09/08/2023.
//

import SwiftUI

struct AnalyticsBodyView: View {
    @FetchRequest var sessions: FetchedResults<Session>
    
    /// The time period over which to show focus data for
    let timeFrame: TimeFrame
    /// The start and end dates of the `timeFrame`. (e.g. start of week and end of week)
    let timeFrameDates: (start: Date, end: Date)
    
    init(timeFrame: TimeFrame) {
        self.timeFrame = timeFrame
        // Calculate the start and end dates for the fetch request depending on the given `timeFrame`
        let now = Date()
        switch timeFrame {
        case .day:
            self.timeFrameDates = (start: now.startOfDay, end: now.endOfDay)
        case .week:
            self.timeFrameDates = (start: now.startOfWeek, end: now.endOfWeek)
        case .month:
            self.timeFrameDates = (start: now.startOfMonth, end: now.endOfMonth)
        case .year:
            self.timeFrameDates = (start: now.startOfyear, end: now.endOfyear)
        }
        
        // Fetch the sessions where the startDate is between the timeFrameDates start and end
        _sessions = FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Session.startDate, ascending: false)],
            predicate: NSPredicate(format: "(startDate >= %@) AND (startDate <= %@)",
                                   self.timeFrameDates.start as CVarArg, self.timeFrameDates.end as CVarArg
                                  ))
    }
    
    var body: some View {
        List {
            HStack {
                SingleStatView(value: totalTime(), label: "Total Time")
                Spacer()
                SingleStatView(value: bestSession(), label: "Best Session")
            }
            .padding(.horizontal)
            
            Section(labelForTimeFrame()) {
                BarChart(data: focusSessionData(), unit: unitForTimeFrame())
            }
            
            Section("Focus Data") {
                if sessions.count != 0 {
                    ForEach(sessions) { session in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Start  \(formatDate(date:session.startDate))")
                                Text("End    \(formatDate(date:session.endDate))")
                            }
                            Spacer()
                            Text(duration(from: session.startDate, to: session.endDate))
                        }
                    }
                } else {
                    Text("No focus data")
                }
            }
        }
    }
    
    /// Get the longest session duration of a single session
    private func bestSession() -> String {        
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
    private func labelForTimeFrame() -> String {
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
    private func unitForTimeFrame() -> Calendar.Component {
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
    private func totalTime() -> String {
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
    private func duration(from startDate: Date?, to endDate: Date?) -> String {
        guard let startDate, let endDate else {return ""}
        let diff = endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970
        return "\(timeStringFrom(diff: diff, showUnits: true, allowedUnits: [.hour, .minute]))"
    }
    
    /// Convert  `FetchedResults<Session>` data to `[FocusSession]` for the Chart.
    /// Always covers the `timeFrameDates` range.
    /// If the `timeFrame` is `.day` then the data is sorted into hours from 00:00 to 23:00
    private func focusSessionData() -> [FocusSession] {
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

struct AnalyticsBodyView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsBodyView(timeFrame: .day)
    }
}
