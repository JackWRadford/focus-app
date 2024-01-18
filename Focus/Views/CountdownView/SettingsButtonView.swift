//
//  SettingsButtonView.swift
//  Focus
//
//  Created by Jack Radford on 18/01/2024.
//

import SwiftUI

struct SettingsButtonView: View {
    @Environment(\.managedObjectContext) private var moc
    @EnvironmentObject private var countdownVM: CountdownViewModel
    
    @StateObject private var settingsVM = SettingsViewModal()
    @State private var presentingSettingsSheet = false
    
    var body: some View {
        Button(action: {presentingSettingsSheet.toggle()}) {
            Image(systemName: "gearshape.fill")
                .foregroundColor(countdownVM.isCounting ? .secondary : .primary)
        }
        .disabled(countdownVM.isCounting)
        .sheet(isPresented: $presentingSettingsSheet) {
            SettingsView(settingsVM: settingsVM)
        }
    }
}

#Preview {
    SettingsButtonView()
        .environmentObject(CountdownViewModel(moc: PersistenceController.previewMoc))
}
