//
//  SkipButtonView.swift
//  Focus
//
//  Created by Jack Radford on 06/07/2023.
//

import SwiftUI

/// Button to skip to the next countdown stage
struct SkipButtonView: View {
    @EnvironmentObject var cvm: CountdownViewModel
    @State private var isPresentingAlert = false
    
    var body: some View {
        if cvm.sessionStarted {
            Button("Skip", action: {isPresentingAlert = true})
                .tint(.secondary)
                .frame(maxWidth: .infinity)
                .confirmationDialog("Skip Stage", isPresented: $isPresentingAlert) {
                    Button("Cancel", role: .cancel) {
                        
                    }
                    Button("Skip") {
                        cvm.nextStage()
                    }
                } message: {
                    Text("Go to the next Pomodoro stage. You cannot go back.")
                }
        }
    }
}

struct SkipButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SkipButtonView()
            .environmentObject(CountdownViewModel())
    }
}
