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
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contextObjectDidChange),
            name: .NSManagedObjectContextObjectsDidChange,
            object: persistantContainer.viewContext)
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
    
    // MARK: - Insert Note
    func add(newNote: NoteData) -> (Bool, Error?) {
        let managedContext = CoreDataManager.sharedManger.persistantContainer.viewContext

        if let noteData = NSEntityDescription.insertNewObject(forEntityName: "Note", into: managedContext) as? Note {
            noteData.isbn13 = newNote.isbn13
            noteData.note = newNote.note
        }
        
        do {
            try managedContext.save()
            return (true, nil)
        } catch {
            print("Could not saved: \(error.localizedDescription)")
            return (false, error)
        }
    }
    
    // MARK: - Delete Note
    func delete(isbn13: String) -> (Bool, Error?) {
        let managedContext = CoreDataManager.sharedManger.persistantContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "isbn13 == %@", isbn13 as CVarArg)
        fetchRequest.predicate = predicate
        
        do {

          let fetchResults: Array = try managedContext.fetch(fetchRequest)

          for fetchResult in fetchResults {
            if let managedObject = fetchResult as? NSManagedObject {

              managedContext.delete(managedObject)
            }
          }
        } catch let error as NSError {
          print(error)
          return (false, error)
        }

        do {
          try managedContext.save()
          return (true, nil)
        } catch let error as NSError {
          return (false, error)
        }
    }
    
    // MARK: - Update
    func update(updateNote: NoteData) -> (Bool ,Error?) {
        let managedContext = CoreDataManager.sharedManger.persistantContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "isbn13 == %@", updateNote.isbn13! as CVarArg)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do {
            let fetchResult = try managedContext.fetch(fetchRequest).first
            if let managedObject = fetchResult as? NSManagedObject {
              managedObject.setValue(updateNote.note, forKey: "note")
            }
            do {
                try managedContext.save()
                return (true, nil)
            } catch {
                return (false, error)
            }
        } catch {
            return (false, error)
        }
    }
    
    func getNote(isbn13: String, completion: @escaping (Note?) -> Void ) {
        let managedContext = CoreDataManager.sharedManger.persistantContainer.viewContext
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        
        let predicate = NSPredicate(format: "isbn13 == %@", isbn13 as CVarArg)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do {
            let note = try managedContext.fetch(fetchRequest).first
            completion(note)
        } catch {
            print(error.localizedDescription)
            completion(nil)
        }
    }
    
    @objc private func contextObjectDidChange(_ notification: NSNotification) {
      NotificationCenter.default.post(name: .memoDataChanged, object: self)
    }
}

extension NSPersistentStoreCoordinator {
    func destroyPersistentStore(type: String) -> NSPersistentStore? {
      guard
        let store = persistentStores.first(where: { $0.type == type }),
        let storeURL = store.url
        else {
          return nil
      }

      try? destroyPersistentStore(at: storeURL, ofType: store.type, options: nil)

      return store
    }

}
