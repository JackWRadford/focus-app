//
//  MainButtonView.swift
//  Focus
//
//  Created by Jack Radford on 06/07/2023.
//

import SwiftUI

/// Button for starting, pausing, and resuming the countdown
struct MainButtonView: View {
    @EnvironmentObject private var countdownVM: CountdownViewModel
    
    // MARK: - Constants
    
    private let radius: CGFloat = 30
    private let verticalPadding: CGFloat = 8
    private let horizontalPadding: CGFloat = 16
    
    // MARK: - Computed Properties
    
    private var tintColor: Color {
        countdownVM.isActive ? countdownVM.isPaused ? .primary : .secondary : .primary
    }
    
    // MARK: - Body
    
    var body: some View {
        Button(action: countdownVM.handleAction) {
            label
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: radius))
        .tint(tintColor)
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Sub Views
    
    private var label: some View {
        Text(countdownVM.actionLabel)
            .fontWeight(.semibold)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .foregroundStyle(.background)
    }
}

struct MainButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MainButtonView()
            .environmentObject(CountdownViewModel(moc: PersistenceController.previewMoc))
    }
}
