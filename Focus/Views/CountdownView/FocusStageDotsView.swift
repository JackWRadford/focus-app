//
//  SwiftUIView.swift
//  Focus
//
//  Created by Jack Radford on 06/07/2023.
//

import SwiftUI

struct FocusStageDotsView: View {
    @EnvironmentObject var cvm: CountdownViewModel
    
    var body: some View {
        HStack {
            ForEach(1...cvm.breaksInterval, id: \.self) { index in
                Circle()
                    .fill(index <= cvm.focusStagesDone ? .primary : .quaternary)
                    .frame(width: 12)
            }
        }
    }
}

struct FocusStageDotsView_Previews: PreviewProvider {
    static var previews: some View {
        FocusStageDotsView()
            .environmentObject(CountdownViewModel())
    }
}
