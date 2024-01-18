//
//  TimeFramePickerView.swift
//  Focus
//
//  Created by Jack Radford on 18/01/2024.
//

import SwiftUI

struct TimeFramePickerView: View {
    @EnvironmentObject private var analyticsVM: AnalyticsViewModel
    
    var body: some View {
        Picker("Time Frame",selection: $analyticsVM.timeFrame) {
            ForEach(TimeFrame.allCases) { option in
                Text(option.rawValue.capitalized)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
}

#Preview {
    TimeFramePickerView()
        .environmentObject(AnalyticsViewModel(moc: PersistenceController.previewMoc))
}
