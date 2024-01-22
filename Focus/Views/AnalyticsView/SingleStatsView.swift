//
//  SingleStatsView.swift
//  Focus
//
//  Created by Jack Radford on 18/01/2024.
//

import SwiftUI

struct SingleStatsView: View {
    @EnvironmentObject private var analyticsViewModel: AnalyticsViewModel
    
    var body: some View {
        HStack {
            SingleStatView("Total Time", analyticsViewModel.totalTime())
            SingleStatView( "Best Session", analyticsViewModel.bestSession())
        }
        .listRowBackground(Color.clear)
        .listRowInsets(.allZero)
    }
}

#Preview {
    List {
        SingleStatsView()
    }
    .environmentObject(AnalyticsViewModel(moc: PersistenceController.previewMoc))
}
