//
//  LocalDBManager.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 15/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit
import CoreData

class LocalDBManager: NSObject {
    static let manager = LocalDBManager()
    
    var context : NSManagedObjectContext{
        get{
            return persistentContainer.viewContext
        }
    }
    
    func createCore(with date : Date?, name : String?, perek : Int16?, priority: Int64){
        
        let obj = TehilimCore(context: self.context)
        obj.date = date as NSDate?
        obj.name = name
        obj.priority = priority
        if let perek = perek {
            obj.perek = perek
        }
        
        self.saveContext()
    }
    
    //MARK: - Core Data
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "TehilimCore")
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
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


extension TehilimCore {
    
    class func coreFethedResultsController() -> NSFetchedResultsController<TehilimCore> {
        let request: NSFetchRequest <TehilimCore> = TehilimCore.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "priority", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        let context = LocalDBManager.manager.context
        
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        
        
        do{
            try controller.performFetch()
        } catch {
            debugPrint(error)
        }
        
//         // Where Locations = your NSManaged Class
//        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TehilimCore")
//        //var locations = try! context.fetch(fetchRequest)
//        let locations = try! context.fetch(fetchRequest) as! [TehilimCore]
//        
//        // Then you can use your properties.
//        for location in locations {
//        
//            print("location:\t\(location.priority) \t\(String(describing: location.perek))")
//            
//        }
        
        return controller
    }
    
    func removeFromDB() {
        LocalDBManager.manager.context.delete(self)
        LocalDBManager.manager.saveContext()
    }
    
    func moveFromDB(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        var objs = TehilimCore.coreFethedResultsController().fetchedObjects
        
        let obj = objs?[sourceIndexPath.row]
        objs?.remove(at: sourceIndexPath.row)
        objs?.insert(obj!, at: destinationIndexPath.row)
        
        var i = 0
        for item in objs! {
            item.setValue(i, forKey: "priority")
            i += 1
        }
        LocalDBManager.manager.saveContext()
    }
    
    class func fetchedAllObject() -> [TehilimCore] {
        guard let objs = TehilimCore.coreFethedResultsController().fetchedObjects else {
            return []
        }
        for obj in objs {
            debugPrint(obj.priority)
        }
        return objs
    }
    
}











