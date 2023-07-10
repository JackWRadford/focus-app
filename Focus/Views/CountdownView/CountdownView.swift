//
//  ContentView.swift
//  Focus
//
//  Created by Jack Radford on 26/06/2023.
//

import SwiftUI

struct CountdownView: View {
    @StateObject private var cvm = CountdownViewModel()
    
    @State private var presentingSettingsSheet = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                Spacer()
                
                Text(cvm.stage != .focus ? cvm.stage.getString() : "")
                    .font(.headline)
                    .frame(minHeight: 24)
                
                Text("\(cvm.time)")
                    .font(.system(size: 64).monospacedDigit())
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                // Focus stage indicator dots
                FocusStageDotsView()
                    .environmentObject(cvm)
                
                Spacer()
                Spacer()
                                
                HStack(alignment: .center) {
                    ResetButtonView()
                        .environmentObject(cvm)
                    
                    MainButtonView()
                        .environmentObject(cvm)
                    
                    SkipButtonView()
                        .environmentObject(cvm)
                }
                .padding(.bottom, 32)
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {presentingSettingsSheet.toggle()}) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.primary)
                    }
                }
            }
            .sheet(isPresented: $presentingSettingsSheet) {
                SettingsView()
            }
        }
        .onReceive(timer) { _ in
            cvm.updateCountdown()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
