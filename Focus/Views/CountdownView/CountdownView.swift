//
//  ContentView.swift
//  Focus
//
//  Created by Jack Radford on 26/06/2023.
//

import SwiftUI
import CoreData

struct CountdownView: View {
    @Environment(\.managedObjectContext) private var moc
    @ObservedObject var countdownVM: CountdownViewModel
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Spacer()
                stage
                time
                FocusStageDotsView()
                Spacer()
                Spacer()
                actions
            }
            .environmentObject(countdownVM)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    AnalyticsButtonView(context: moc)
                    SettingsButtonView()
                }
            }
        }
        .onReceive(timer) { _ in
            countdownVM.updateCountdown()
        }
        .environmentObject(countdownVM)
    }
    
    private var stage: some View {
        Text(countdownVM.stage != .focus ? countdownVM.stage.getString() : "")
            .font(.headline)
            .frame(minHeight: 24)
    }
    
    private var time: some View {
        Text("\(countdownVM.time)")
            .font(.system(size: 64).monospacedDigit())
            .fontWeight(.bold)
            .padding(.top, 20)
            .padding(.bottom, 10)
    }
    
    private var actions: some View {
        HStack(alignment: .center) {
            ResetButtonView()
            MainButtonView()
            SkipButtonView()
        }
        .padding(.bottom, 32)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(countdownVM: CountdownViewModel(moc: PersistenceController.previewMoc))
            .environment(\.managedObjectContext, PersistenceController.previewMoc)
    }
}
