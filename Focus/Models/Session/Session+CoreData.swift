//
//  Session+CoreData.swift
//  Focus
//
//  Created by Jack Radford on 17/01/2024.
//

import Foundation
import CoreData

extension Session {
    
    /// FetchRequest for the sessions where the startDate is between the timeFrameDates start and end
    ///
    /// - Parameters:
    ///   - start: The start Date of the time window to fetch sessions for.
    ///   - end: The end Date of the time window to fetch sessions for.
    ///
    /// - Returns: The NSFetchRequest.
    static func fetchSessions(from start: Date, to end: Date) -> NSFetchRequest<Session> {
        let request = Session.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Session.startDate, ascending: false)]
        request.predicate = NSPredicate(format: "(startDate >= %@) AND (startDate <= %@)", start as CVarArg, end as CVarArg)
        return request
    }
    
    /// Add a new Session with the given startDate and endDate.
    /// Also saves the context.
    ///
    /// - Parameters:
    ///   - startDate: The Date that the Session started.
    ///   - endDate: The Date that the Session ended.
    ///   - context: The NSManagedObjectContext in which to save the Session.
    static func createWith(startDate: Date, endDate: Date, into context: NSManagedObjectContext) {
        let _ = Session(start: startDate, end: endDate, insertInto: context)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
