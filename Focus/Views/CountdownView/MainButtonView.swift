//
//  MainButtonView.swift
//  Focus
//
//  Created by Jack Radford on 06/07/2023.
//

import SwiftUI

/// Button for starting, pausing, and resuming the countdown
struct MainButtonView: View {
    @EnvironmentObject var cvm: CountdownViewModel
    
    var body: some View {
        Button(action: cvm.handleAction) {
            Text(cvm.actionLabel)
                .fontWeight(.semibold)
                .padding([.bottom, .top], 8)
                .padding([.leading, .trailing], 16)
                .foregroundStyle(.background)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 30))
        .tint(cvm.isActive ? cvm.isPaused ? .primary : .secondary : .primary)
        .frame(maxWidth: .infinity)
    }
}

struct MainButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MainButtonView()
            .environmentObject(CountdownViewModel(moc: PersistenceController.previewMoc))
    }
}
