//
//  BarChart.swift
//  Focus
//
//  Created by Jack Radford on 09/08/2023.
//

import SwiftUI
import Charts

struct BarChart: View {
    @EnvironmentObject private var analyticsVM: AnalyticsViewModel
    
    private var data: [FocusSession] {
        analyticsVM.focusSessionData()
    }
    
    private var unit: Calendar.Component {
        analyticsVM.unitForTimeFrame()
    }
    
    var body: some View {
        Section {
            VStack(alignment: .leading) {
                Text("Focus Time").bold()
                Chart(data) { datum in
                    BarMark(
                        x: .value("Time", datum.date, unit: unit),
                        y: .value("Focus Minutes", datum.duration)
                    )
                    .foregroundStyle(Color.primary)
                }
                .padding(.top, 8)
                .padding(.bottom, 4)
                .frame(height: 220)
            }
        }
    }
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        List {
            BarChart()
                .environmentObject(AnalyticsViewModel(moc: PersistenceController.previewMoc))
        }
    }
}
