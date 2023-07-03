//
//  SettingsView.swift
//  Focus
//
//  Created by Jack Radford on 28/06/2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var svm = SettingsViewModal()
    
    var body: some View {
        NavigationStack {
            List {
                Section("Timer length") {
                    TextFieldSettingView(label: "Focus Time", text: $svm.focusDuration)
                    TextFieldSettingView(label: "Short Break", text: $svm.shortBreakDuration)
                    TextFieldSettingView(label: "Long Break", text: $svm.longBreakDuration)
                }
                
                Section("Session") {
                    TextFieldSettingView(label: "Breaks interval", text: $svm.breaksInterval)
                    Toggle("Auto-start Focus", isOn: $svm.autoStartFocus)
                    Toggle("Auto-start Breaks", isOn: $svm.autoStartBreaks)
                }
                
                Section("General") {
                    Toggle("Notifications", isOn: $svm.notificationsEnabled)
                    Toggle("Vibrate on silent", isOn: $svm.vibrateOnSilent)
                }
                
                Text("Version 0.0.1")
                    .foregroundColor(.gray)
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
        .onDisappear {
            // Save settings TextField changes
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
