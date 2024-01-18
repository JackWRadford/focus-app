//
//  NotificationToggleView.swift
//  Focus
//
//  Created by Jack Radford on 18/01/2024.
//

import SwiftUI

struct NotificationToggleView: View {
    @EnvironmentObject private var settingsVM: SettingsViewModal
    
    var body: some View {
        Toggle("Notifications", isOn: $settingsVM.notificationsEnabled)
            .onChange(of: settingsVM.notificationsEnabled) { value in
                settingsVM.handleNotificationsToggle(value: value)
            }
            .alert("Enable Notifications", isPresented: $settingsVM.presentingNotificationsAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Okay") {
                    // Open the app's notification settings
                    settingsVM.openDeviceSettings()
                }
            } message: {
                Text("Go to settings to change your notification preferences.")
            }
    }
}

#Preview {
    NotificationToggleView()
        .environmentObject(SettingsViewModal())
}
