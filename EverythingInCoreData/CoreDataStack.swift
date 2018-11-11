//
//  CoreDataStack.swift
//  EverythingInCoreData
//
//  Created by saket bhushan on 10/11/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    private init() {
    }
    
   lazy var persistanceStoreCoordinator : NSPersistentStoreCoordinator = {
    
        let momdURL = Bundle.main.url(forResource: "EverythingInCoreData", withExtension: "momd")
    
    let psc = NSPersistentStoreCoordinator(managedObjectModel: NSManagedObjectModel(contentsOf: momdURL!)!)
    
        let urlDB = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!.appendingPathComponent("EverythingInCoreData.sqlite")
    
        try? psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: urlDB, options: nil)

    return psc
    }()
    
    
    lazy var managedContext : NSManagedObjectContext = {
        let mc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mc.parent = self.parentContext
        return mc
    }()
    
    lazy var parentContext: NSManagedObjectContext = {
        let pc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        pc.persistentStoreCoordinator = self.persistanceStoreCoordinator
        return pc
    }()
    
    
    
}
