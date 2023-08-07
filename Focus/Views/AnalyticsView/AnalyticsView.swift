//
//  AnalyticsView.swift
//  Focus
//
//  Created by Jack Radford on 07/08/2023.
//

import SwiftUI

struct AnalyticsView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "startDate", ascending: false)]) var sessions: FetchedResults<Session>
    
    var body: some View {
        VStack {
            Text(totalTime())
            List(sessions) { session in
                HStack {
                    VStack(alignment: .leading) {
                        Text("Start  \(formatDate(date:session.startDate))")
                        Text("End    \(formatDate(date:session.endDate))")
                    }
                    Spacer()
                    Text(duration(from: session.startDate, to: session.endDate))
                }
            }
        }
        .navigationTitle("Analytics")
    }
    
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

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AnalyticsView()
                .environment(\.managedObjectContext, PersistenceController.previewMoc)
                .environmentObject(CountdownViewModel(moc: PersistenceController.previewMoc))
        }
    }
}
