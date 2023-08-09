//
//  AnalyticsBodyView.swift
//  Focus
//
//  Created by Jack Radford on 09/08/2023.
//

import SwiftUI

struct AnalyticsBodyView: View {
    @FetchRequest var sessions: FetchedResults<Session>
    
    let timeFrame: TimeFrame
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
                VStack(alignment: .leading) {
                    Text(totalTime())
                        .font(.title)
                    Text("Total Time")
                }
            }
            if timeFrame != .day {
                Section("Chart") {
                    BarChart(data: focusSessionData(from: sessions), unit: unit(for: timeFrame))
                }
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
    
    /// Get the Chart's date unit depending on the `timeFrame`
    private func unit(for timeFrame: TimeFrame) -> Calendar.Component {
        switch timeFrame {
        case .day:
            return .hour
        case .week, .month:
            return .day
        case .year:
            return .month
        }
    }
    
    /// Convert  `FetchedResults<Session>` data to `[FocusSession]` for the Chart.
    /// Always covers the `timeFrameDates` range
    private func focusSessionData(from sessions: FetchedResults<Session>) -> [FocusSession] {
        var data: [FocusSession] = []
        // Convert
        sessions.forEach { session in
            guard let start = session.startDate, let end = session.endDate else { return }
            let date = start.startOfDay
            let duration = Calendar.current.dateComponents([.minute], from: start, to: end).minute ?? 10
            data.append(.init(date: date, duration: duration))
        }
        // Add start and end dates with duration 0 to make sure that the chart covers the desired range
        data.append(.init(date: timeFrameDates.start, duration: 0))
        data.append(.init(date: timeFrameDates.end, duration: 0))
        return data
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
        return "\(timeStringFrom(diff: sum, showUnits: true))"
    }
    
    /// Returns the duration between the `startDate` and `endDate`
    private func duration(from startDate: Date?, to endDate: Date?) -> String {
        guard let startDate, let endDate else {return ""}
        let diff = endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970
        return "\(timeStringFrom(diff: diff, showUnits: true))"
    }
}

struct AnalyticsBodyView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsBodyView(timeFrame: .day)
    }
}



