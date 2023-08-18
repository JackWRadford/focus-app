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
            Picker("Time Frame",selection: $selectedTimeFrame) {
                ForEach(TimeFrame.allCases) { option in
                    Text(option.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            AnalyticsBodyView(timeFrame: selectedTimeFrame, moc: moc)
        }
        .navigationTitle("Analytics")        
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
            .environment(\.managedObjectContext, PersistenceController.previewMoc)
            .environmentObject(CountdownViewModel(moc: PersistenceController.previewMoc))
    }
}
