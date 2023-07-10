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
    
    /// Infomation property list version
    let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    /// Infomation property list build number
    let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("Timer length") {
                    TextFieldSettingView(label: "Focus Time", text: $svm.focusDuration)
                    TextFieldSettingView(label: "Short Break", text: $svm.shortBreakDuration)
                    TextFieldSettingView(label: "Long Break", text: $svm.longBreakDuration)
                }
                
                Section {
                    TextFieldSettingView(label: "Breaks interval", text: $svm.breaksInterval)
                } footer: {
                    Text("The number of short breaks before a long break.")
                }
                
                Section("General") {                    
                    Toggle("Notifications", isOn: $svm.notificationsEnabled)
                        .onChange(of: svm.notificationsEnabled) { value in
                            svm.handleNotificationsToggle(value: value)
                        }                        
                        .alert("Enable Notifications", isPresented: $svm.presentingNotificationsAlert) {
                            Button("Cancel", role: .cancel) {}
                            Button("Okay") {
                                // Open the app's notification settings
                                svm.openDeviceSettings()
                            }
                        } message: {
                            Text("Go to settings to change your notification preferences.")
                        }
                }
                
                Text("Version \(versionNumber) (\(buildNumber))")
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
