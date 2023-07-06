//
//  ResetButtonView.swift
//  Focus
//
//  Created by Jack Radford on 06/07/2023.
//

import SwiftUI

/// Button to reset the countdown
struct ResetButtonView: View {
    @EnvironmentObject var cvm: CountdownViewModel
    
    var body: some View {
        if cvm.sessionStarted {
            Button("Reset", action: cvm.reset)
                .tint(.secondary)
                .frame(maxWidth: .infinity)
        }
    }
}

struct ResetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ResetButtonView()
            .environmentObject(CountdownViewModel())
    }
}
