//
//  SessionsListView.swift
//  Focus
//
//  Created by Jack Radford on 18/01/2024.
//

import SwiftUI

struct SessionsListView: View {
    @EnvironmentObject private var analyticsViewModel: AnalyticsViewModel
    
    var body: some View {
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

#Preview {
    List {
        SessionsListView()
    }
    .environmentObject(AnalyticsViewModel(moc: PersistenceController.previewMoc))
}
