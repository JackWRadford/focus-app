//
//  AnalyticsBodyView.swift
//  Focus
//
//  Created by Jack Radford on 09/08/2023.
//

import SwiftUI
import CoreData

struct AnalyticsBodyView: View {    
    @ObservedObject private var analyticsViewModel: AnalyticsViewModel
    
    init(timeFrame: TimeFrame, moc: NSManagedObjectContext) {        
        self.analyticsViewModel = AnalyticsViewModel(timeFrame: timeFrame, moc: moc)
    }
    
    var body: some View {
        List {
            singleStats
            Section(analyticsViewModel.labelForTimeFrame()) {
                BarChart(data: analyticsViewModel.focusSessionData(), unit: analyticsViewModel.unitForTimeFrame())
            }
            dataList
        }
    }
    
    private var singleStats: some View {
        HStack {
            SingleStatView(value: analyticsViewModel.totalTime(), label: "Total Time")
            Spacer()
            SingleStatView(value: analyticsViewModel.bestSession(), label: "Best Session")
        }
        .padding(.horizontal)
    }
    
    private var dataList: some View {
        Section("Focus Data") {
            if analyticsViewModel.sessions.count != 0 {
                ForEach(analyticsViewModel.sessions) { session in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Start  \(session.startDateString)")
                            Text("End    \(session.endDateString)")
                        }
                        Spacer()
                        Text(analyticsViewModel.duration(from: session.startDate, to: session.endDate))
                    }
                }
            } else {
                Text("No focus data")
            }
        }
    }
}

struct AnalyticsBodyView_Previews: PreviewProvider {
    static var moc = PersistenceController.previewMoc
    static var previews: some View {
        AnalyticsBodyView(timeFrame: .day, moc: moc)
            .environment(\.managedObjectContext, moc)
    }
}
