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
    
    /// Fetch the sessions where the startDate is between the timeFrameDates start and end    
    func fetchSessions(from start: Date, to end: Date) -> [Session] {
        var sessions: [Session] = []
        let request = NSFetchRequest<Session>(entityName: "Session")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Session.startDate, ascending: false)]
        request.predicate = NSPredicate(format: "(startDate >= %@) AND (startDate <= %@)", start as CVarArg, end as CVarArg)
        
        do {
            sessions = try moc.fetch(request)
        } catch {
            print("Error when fetching sessions: \(error.localizedDescription)")
        }
        
        return sessions
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
