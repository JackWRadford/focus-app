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
    @State private var isPresentingAlert = false
    
    var body: some View {
        if cvm.sessionStarted {
            Button("Done", action: {isPresentingAlert = true})
                .tint(.secondary)
                .frame(maxWidth: .infinity)
                .alert("Reset Pomodoro", isPresented: $isPresentingAlert) {
                    Button("Cancel", role: .cancel) {
                        
                    }
                    Button("Done") {
                        cvm.reset()
                    }
                } message: {
                    VStack {
                        Text("Your whole Pomodoro session will be reset. Focus time until now will be shown in analytics.")
                    }
                }
        }
    }
}

struct ResetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ResetButtonView()
            .environmentObject(CountdownViewModel())
    }
}
