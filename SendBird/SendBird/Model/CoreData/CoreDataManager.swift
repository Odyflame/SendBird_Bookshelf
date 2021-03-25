//
//  CoreDataManager.swift
//  SendBird
//
//  Created by apple on 2021/03/25.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
    static let sharedManger = CoreDataManager()
    
    override init() {
        super.init()
        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(<#T##@objc method#>),
//            name: .NSManagedObjectContextObjectsDidChange,
//            object: persis)
    }
    
    lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: BooksConstant.coreDataModelName)
        container.loadPersistentStores { (_, error) in
            if let nsError = error as NSError? {
                fatalError("here is the error that: \(nsError)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = CoreDataManager.sharedManger.persistantContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("here is the error that: \(nsError)")
            }
        }
    }
    
//    // MARK: - Insert Note
//    func add(newNote: String, isbn13: String) -> (Bool, Error) {
//        let managedContext = CoreDataManager.sharedManger.persistantContainer.viewContext
//
//        //var coredataTypeArr: []
//    }
}
