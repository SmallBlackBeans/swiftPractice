//
//  CoreDataStack.swift
//  CoreData_Swift
//
//  Created by 韩承海 on 2017/11/22.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit

import CoreData
class CoreDataStack: NSObject {

    let modelName = "Dog Walk"

     private lazy var applicationDocumentDir: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.last!
    }()
    
    lazy var content: NSManagedObjectContext = {
       var managedObjectContext = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.psc
        return managedObjectContext
    }()
    
    private lazy var psc: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator.init(managedObjectModel: self.manageObjectModel)
        let url = self.applicationDocumentDir.appendingPathComponent(self.modelName)
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption: true]
           try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            print("error add persisten store.")
        }
        return coordinator
    }()
    
    
    private lazy var manageObjectModel: NSManagedObjectModel = {
        let modelUrl = Bundle.main.url(forResource: self.modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelUrl)!
    }()
    
    
    func saveContext() {
        if self.content.hasChanges {
            do {
                try self.content.save()
            } catch let error as NSError {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
}
