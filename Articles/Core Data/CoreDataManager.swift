//
//  CoreDataManager.swift
//  Articles
//
//  Created by Shahrukh Malik on 17/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import CoreData
import Foundation

class CoreDataManager {
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Articles")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func managedObjectContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = managedObjectContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    // MARK: - Helper methods
    
    func insertSearchTerm(searchTerm: String, withDate date: Date) {
        let searchMO = NSEntityDescription.insertNewObject(forEntityName: "Search", into: managedObjectContext()) as! Search
        searchMO.term = searchTerm
        searchMO.date = date as NSDate
        
        saveContext()
    }
    
    func fetchRecentSearches() -> [Search]? {
        let request = NSFetchRequest<Search>(entityName: "Search")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        request.fetchLimit = 10
        
        var searches: [Search]? = nil
        
        let moc = managedObjectContext()
        
        do {
            searches = try moc.fetch(request) as [Search]
        } catch let error {
            print("failed to fetch search object: \(error)")
        }
        
        return searches
    }
}
