//
//  CoreDataManager.swift
//  MyNotes
//
//  Created by Александра Лесовская on 21.04.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK: - Static Properties
    static let shared = CoreDataManager()
    
    // MARK: - Public Properties
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyNotes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Initializers
    private init() {}
    
    // MARK: - CRUD (Create, Read, Update, Delete)
    func create(_ notesTitle: String,_ notesSubtitle: String, completion: (Note) -> Void) {
        let note = Note(context: viewContext)
        note.title = notesTitle
        note.subtitle = notesSubtitle
        completion(note)
        saveContext()
    }
    
    func create(_ notesTitle: String,_ notesSubtitle: String) {
        let note = Note(context: viewContext)
        note.title = notesTitle
        note.subtitle = notesSubtitle
        saveContext()
    }
    
    func fetchData(completion: (Result<[Note], Error>) -> Void) {
        let fetchRequest = Note.fetchRequest()
        
        do {
            let notes = try self.viewContext.fetch(fetchRequest)
            completion(.success(notes))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func update(_ note: Note, newTitle: String, newSubtitle: String) {
        note.title = newTitle
        note.subtitle = newSubtitle
        saveContext()
    }
    
    func delete(_ note: Note) {
        viewContext.delete(note)
        saveContext()
    }

    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
