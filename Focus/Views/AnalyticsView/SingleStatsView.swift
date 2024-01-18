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
            SingleStatView(value: analyticsViewModel.totalTime(), label: "Total Time")
            Spacer()
            SingleStatView(value: analyticsViewModel.bestSession(), label: "Best Session")
        }
        .padding(.horizontal)
    }
}

#Preview {
    SingleStatsView()
        .environmentObject(AnalyticsViewModel(moc: PersistenceController.previewMoc))
}
