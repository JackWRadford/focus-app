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
    
    @FetchRequest private var sessions: FetchedResults<Session>
    
    init(analyticsVM: AnalyticsViewModel) {
        self.analyticsVM = analyticsVM
        
        // Initialise the FetchRequest.
        _sessions = FetchRequest(
            fetchRequest: Session.fetchSessions(
                from: analyticsVM.timeFrameDates.start,
                to: analyticsVM.timeFrameDates.end
            )
        )
    }
    
    var body: some View {
        VStack {
            TimeFramePickerView()
            List {
                SingleStatsView()
                BarChart()
                SessionsListView()
            }
        }
        .onAppear(perform: updateSessions)
        .onChange(of: Array(sessions)) { _ in updateSessions() }
        .navigationTitle("Analytics")
        .environmentObject(analyticsVM)
    }
    
    /// Update the ViewModel sessions when the FetchedResults change.
    private func updateSessions() {
        analyticsVM.sessions = Array(sessions)
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static let previewContext = PersistenceController.previewMoc
    static var previews: some View {
        AnalyticsView(analyticsVM: AnalyticsViewModel(moc: previewContext))
            .environment(\.managedObjectContext, previewContext)
    }
}
