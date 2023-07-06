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
    
    var body: some View {
        if cvm.sessionStarted {
            Button("Skip", action: cvm.nextStage)
                .tint(.secondary)
                .frame(maxWidth: .infinity)
        }
    }
}

struct SkipButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SkipButtonView()
            .environmentObject(CountdownViewModel())
    }
}
