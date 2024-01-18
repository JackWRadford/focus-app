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
    @State private var presentingSettingsSheet = false
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var actionColor: Color {
        countdownVM.isCounting ? .secondary : .primary
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                stage
                Spacer()
                time
                FocusStageDotsView()
                Spacer()
                Spacer()
                actions
            }
            .environmentObject(countdownVM)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    analyticsAction
                    settingsAction
                }
            }
            .sheet(isPresented: $presentingSettingsSheet) {
                SettingsView()
            }
        }
        .onReceive(timer) { _ in
            countdownVM.updateCountdown()
        }
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
    
    private var analyticsAction: some View {
        NavigationLink(destination: AnalyticsView()) {
            Image(systemName: "chart.pie.fill")
                .foregroundColor(actionColor)
        }
        .disabled(countdownVM.isCounting)
    }
    
    private var settingsAction: some View {
        Button(action: {presentingSettingsSheet.toggle()}) {
            Image(systemName: "gearshape.fill")
                .foregroundColor(actionColor)
        }
        .disabled(countdownVM.isCounting)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(countdownVM: CountdownViewModel(moc: PersistenceController.previewMoc))
            .environment(\.managedObjectContext, PersistenceController.previewMoc)
    }
}
