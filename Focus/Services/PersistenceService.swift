//
//  PersistenceService.swift
//  Focus
//
//  Created by Jack Radford on 07/08/2023.
//

import Foundation
import CoreData

/// Handles Session persistence with CoreData
struct PersistenceService {
    let moc: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    /// Add a new Session with `startDate` and `endDate`.
    /// Attempt to save the managed object context
    func addSession(startDate: Date, endDate: Date) {
        let session = Session(context: moc)
        session.id = UUID()
        session.startDate = startDate
        session.endDate = endDate
        
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
