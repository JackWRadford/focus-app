//
//  ResetButtonView.swift
//  Focus
//
//  Created by Jack Radford on 06/07/2023.
//

import SwiftUI

/// Button to reset the countdown
struct ResetButtonView: View {
    @EnvironmentObject private var countdownVM: CountdownViewModel
    @State private var isPresentingAlert = false
    
    var body: some View {
        if countdownVM.sessionStarted {
            button
                .confirmationDialog("Reset Pomodoro", isPresented: $isPresentingAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Done") { countdownVM.reset() }
                } message: {
                    Text("Focus time until now will be shown in analytics. Your whole Pomodoro session will be reset. ")
                }
        }
    }
    
    private var button: some View {
        Button("Done", action: { isPresentingAlert = true })
            .tint(.secondary)
            .frame(maxWidth: .infinity)
    }
}

struct ResetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ResetButtonView()
            .environmentObject(CountdownViewModel(moc: PersistenceController.previewMoc))
    }
}
