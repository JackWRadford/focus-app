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
            VStack {
                
                Spacer()
                
                Text(cvm.stage != .focus ? cvm.stage.getString() : "")
                    .font(.headline)
                    .frame(minHeight: 24)
                
                Text("\(cvm.time)")
                    .font(.system(size: 50).monospacedDigit())
                    .fontWeight(.bold)
                
                Spacer()
                                
                HStack(alignment: .center) {
                    if cvm.sessionStarted {
                        Button("Reset", action: cvm.reset)
                            .tint(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                    
                    Button(action: cvm.handleAction) {
                        Text(cvm.actionLabel)
                            .fontWeight(.semibold)
                            .padding([.bottom, .top], 8)
                            .padding([.leading, .trailing], 16)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 30))
                    .tint(cvm.isActive ? cvm.isPaused ? .primary : .secondary : .primary)                    
                    .frame(maxWidth: .infinity)
                    
                    if cvm.sessionStarted {
                        Button("Skip", action: cvm.nextStage)
                            .tint(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.bottom)
                
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
