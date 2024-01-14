//
//  FocusApp.swift
//  Focus
//
//  Created by Jack Radford on 26/06/2023.
//

import SwiftUI

@main
struct FocusApp: App {
    let moc = PersistenceController.shared.container.viewContext
    
    @StateObject private var coundownVM = CountdownViewModel(
        moc: PersistenceController.shared.container.viewContext
    )
    
    var body: some Scene {
        WindowGroup {
            CountdownView(countdownVM: coundownVM)
                .environment(\.managedObjectContext, moc)
        }
    }
}
