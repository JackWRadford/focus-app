//
//  FocusApp.swift
//  Focus
//
//  Created by Jack Radford on 26/06/2023.
//

import SwiftUI

@main
struct FocusApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
