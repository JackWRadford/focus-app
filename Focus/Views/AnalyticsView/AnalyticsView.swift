//
//  AnalyticsView.swift
//  Focus
//
//  Created by Jack Radford on 07/08/2023.
//

import SwiftUI

struct AnalyticsView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var selectedTimeFrame: TimeFrame = .day
    
    var body: some View {
        VStack {
            picker
            AnalyticsBodyView(timeFrame: selectedTimeFrame, moc: moc)
        }
        .navigationTitle("Analytics")        
    }
    
    private var picker: some View {
        Picker("Time Frame",selection: $selectedTimeFrame) {
            ForEach(TimeFrame.allCases) { option in
                Text(option.rawValue.capitalized)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
            .environment(\.managedObjectContext, PersistenceController.previewMoc)
            .environmentObject(CountdownViewModel(moc: PersistenceController.previewMoc))
    }
}
