//
//  AnalyticsView.swift
//  Focus
//
//  Created by Jack Radford on 07/08/2023.
//

import SwiftUI
import CoreData

struct AnalyticsView: View {
    @ObservedObject var analyticsVM: AnalyticsViewModel

    var body: some View {
        VStack {
            TimeFramePickerView()
            List {
                SingleStatsView()
                BarChart()
                SessionsListView()
            }
        }
        .navigationTitle("Analytics")
        .environmentObject(analyticsVM)
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static let previewContext = PersistenceController.previewMoc
    static var previews: some View {
        AnalyticsView(analyticsVM: AnalyticsViewModel(moc: previewContext))
            .environment(\.managedObjectContext, previewContext)
            .environmentObject(CountdownViewModel(moc: previewContext))
    }
}
