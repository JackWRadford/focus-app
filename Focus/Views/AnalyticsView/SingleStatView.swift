//
//  SingleStatView.swift
//  Focus
//
//  Created by Jack Radford on 10/08/2023.
//

import SwiftUI

/// Displays the label in smaller secondary font below the value, in a rounded rectangle.
///
/// - Parameters:
///   - label: A LocalizedStringResource for the label..
///   - value: A String representing the value.
///
struct SingleStatView: View {
    var label: LocalizedStringResource
    var value: String
    
    init(_ label: LocalizedStringResource,_ value: String) {
        self.label = label
        self.value = value
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(value)
                .font(.title)
                .bold()
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    List {
        SingleStatView("Total Workouts", "247")
    }
}
