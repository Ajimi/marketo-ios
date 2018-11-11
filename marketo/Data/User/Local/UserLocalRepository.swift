//
//  UserLocalRepository.swift
//  marketo
//
//  Created by selim ajimi on 11/11/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import CoreData

class UserLocalRepository{
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
    
    
}

// MARK: - Save Context
extension UserLocalRepository{
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - Local Repository
extension UserLocalRepository: UserDataSource{
    func getAll(completion:@escaping (Any)->Void) -> [User] {
        return [User]()
    }
    
    func get(identifier: Int) -> User? {
        return User(fullName: "", username: "", password: "", email: "")
    }
    
    func create(a: User) -> Bool {
        return true
    }
    
    func update(a: User) -> Bool {
        return true
    }
    
    func delete(a: User) -> Bool {
        return true
    }
}

