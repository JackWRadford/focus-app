//
//  ContentView.swift
//  Focus
//
//  Created by Jack Radford on 26/06/2023.
//

import SwiftUI

struct CountdownView: View {
    @StateObject private var countdownVm = CountdownViewModel()
    @State private var presentingSettingsSheet = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                Text("\(countdownVm.time)")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: handlePress) {
                    Text(countdownVm.isActive ? "Cancel" :"Focus")
                        .fontWeight(.semibold)
                        .padding([.bottom, .top], 8)
                        .padding([.leading, .trailing], 16)
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom)
                .tint(countdownVm.isActive ? .secondary : .primary)
                
            }            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {presentingSettingsSheet.toggle()}) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .sheet(isPresented: $presentingSettingsSheet) {
                SettingsView()
            }
        }
        .onReceive(timer) { _ in
            countdownVm.updateCountdown()
        }
    }
    
    /// Reset coundown if active, otherwise start the countdown
    private func handlePress() {
        if (countdownVm.isActive) {
            countdownVm.reset()
        } else {
            countdownVm.start(minutes: countdownVm.minutes)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
