//
//  AnalyticsBodyView.swift
//  Focus
//
//  Created by Jack Radford on 09/08/2023.
//

import SwiftUI

struct AnalyticsBodyView: View {
    @FetchRequest var sessions: FetchedResults<Session>
    
    
    
    init(timeFrame: TimeFrame) {
        /// Calculate the start and end dates for the fetch request depending on the given `timeFrame`
        func dates(for timeFrame: TimeFrame) -> (start: Date, end: Date) {
            let now = Date()
            switch timeFrame {
            case .day:
                return (start: now.startOfDay, end: now.endOfDay)
            case .week:
                return (start: now.startOfWeek, end: now.endOfWeek)
            case .month:
                return (start: now.startOfMonth, end: now.endOfMonth)
            case .year:
                return (start: now.startOfyear, end: now.endOfyear)
            }
        }
        let timeFrameDates = dates(for: timeFrame)
        
        _sessions = FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Session.startDate, ascending: false)],
            predicate: NSPredicate(format: "(startDate >= %@) AND (startDate <= %@)",
                                   timeFrameDates.start as CVarArg, timeFrameDates.end as CVarArg
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



