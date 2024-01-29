//
//  Persistence.swift
//  Focus
//
//  Created by Jack Radford on 26/06/2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Focus")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

// MARK: - Preview
extension PersistenceController {
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        generatePreviewData(viewContext)
        return result
    }()
    
    static let previewMoc = preview.container.viewContext
    
    /// Generates some Sessions and saves them to the given viewContext.
    ///
    /// - Parameter viewContext: The NSManagedObjectContext to use.
    static private func generatePreviewData(_ viewContext: NSManagedObjectContext) {
        let calendar = Calendar.current
        for index in 0..<500 {
            let end = calendar.date(byAdding: .hour, value: -4 * index, to: .now) ?? Date()
            let newSession = Session(context: viewContext)
            newSession.id = UUID()
            newSession.startDate = calendar.date(byAdding: .minute, value: -Int.random(in: 5..<121), to: end)
            newSession.endDate = end
        }
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
