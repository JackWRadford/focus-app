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
        Section {
            if analyticsViewModel.sessions.count != 0 {
                ForEach(analyticsViewModel.sessions) { session in
                    SessionsListItemView(session)
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
