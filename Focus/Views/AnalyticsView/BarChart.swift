//
//  BarChart.swift
//  Focus
//
//  Created by Jack Radford on 09/08/2023.
//

import SwiftUI
import Charts

struct BarChart: View {
    let data: [FocusSession]
    let unit: Calendar.Component
    
    init(data: [FocusSession], unit: Calendar.Component) {
        self.data = data
        self.unit = unit
    }
    
    var body: some View {
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

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(data: FocusSession.randomTestData(), unit: .day)
    }
}
