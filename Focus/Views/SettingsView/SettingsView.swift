//
//  SettingsView.swift
//  Focus
//
//  Created by Jack Radford on 28/06/2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var settingsVM = SettingsViewModal()
    
    var body: some View {
        NavigationStack {
            List {
                timerLengthSection
                breakIntervalSection
                generalSection
                VersionView()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: {dismiss()})
                        .tint(.primary)
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(action: {hideKeyboard()}) {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
        }
        .environmentObject(settingsVM)
    }
    
    private var timerLengthSection: some View {
        Section("Timer length") {
            TextFieldSettingView(label: "Focus Time", text: $settingsVM.focusDuration)
            TextFieldSettingView(label: "Short Break", text: $settingsVM.shortBreakDuration)
            TextFieldSettingView(label: "Long Break", text: $settingsVM.longBreakDuration)
        }
    }
    
    private var breakIntervalSection: some View {
        Section {
            TextFieldSettingView(label: "Breaks interval", text: $settingsVM.breaksInterval)
        } footer: {
            Text("The number of short breaks before a long break.")
        }
    }
    
    private var generalSection: some View {
        Section("General") {
            NotificationToggleView()
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
