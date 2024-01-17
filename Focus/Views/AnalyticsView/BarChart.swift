//
//  BarChart.swift
//  Focus
//
//  Created by Jack Radford on 09/08/2023.
//

import SwiftUI
import Charts

struct FocusSession: Identifiable {
    var date: Date
    var duration: Int
    var id = UUID()
}

extension FocusSession {
    static func randomTestData() -> [FocusSession] {
        var data: [FocusSession] = []
        (0..<7).forEach { index in
            let date = Calendar.current.date(byAdding: .day, value: -1 * index, to: .now) ?? Date()
            let duration = Int.random(in: 0..<121)
            data.append(.init(date: date, duration: duration))
        }
        return data
    }
}

struct BarChart: View {
    let data: [FocusSession]
    let unit: Calendar.Component
    
    init(data: [FocusSession], unit: Calendar.Component) {
        self.data = data
        self.unit = unit
    }
    
    var body: some View {
        Chart(data) { datum in
            BarMark(
                x: .value("Time", datum.date, unit: unit),
                y: .value("Focus Minutes", datum.duration)
            )
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .frame(height: 220)
    }
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(data: FocusSession.randomTestData(), unit: .day)
    }
}
