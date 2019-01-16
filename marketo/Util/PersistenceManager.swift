//
//  PersistenceManager.swift
//  marketo
//
//  Created by Othmen on 11/26/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import CoreData

final class PersistenceManager {
    
    private init() {}
    static let shared = PersistenceManager()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "marketo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data Saving supportÒ
    func save() {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        if context.hasChanges {
            do {
                try context.save()
                print("saved successfully")
                
                
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        
        let entityName = String(describing: objectType)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
            
        } catch {
            print(error)
            return [T]()
        }
        
    }
    
    
    func fetchById<T: NSManagedObject>(_ objectType: T.Type, _ id: Int) -> [T] {
        
        let entityName = String(describing: objectType)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
            
        } catch {
            print(error)
            return [T]()
        }
        
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        save()
    }
}
