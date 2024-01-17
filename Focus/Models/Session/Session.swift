//
//  Session.swift
//  Focus
//
//  Created by Jack Radford on 17/01/2024.
//

import Foundation
import CoreData

extension Session {
    
    convenience init(start: Date, end: Date, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = UUID()
        self.startDate = start
        self.endDate = end
    }
    
    var startDateString: String {
        userFacingString(for: startDate)
    }
    
    var endDateString: String {
        userFacingString(for: endDate)
    }
    
    // MARK: - Functions
    private func userFacingString(for date: Date?) -> String {
        return date?.formatted(date: .numeric, time: .shortened) ?? "Unknown"
    }
}
