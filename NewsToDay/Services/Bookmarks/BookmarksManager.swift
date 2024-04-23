//
//  BookmarksManager.swift
//  NewsToDay
//
//  Created by Келлер Дмитрий on 09.04.2024.
//

import Foundation
import CoreData
import NetworkManager

final class BookmarksManager {
    // MARK: - Properties
    public static let shared = BookmarksManager()
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsCoreData")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    
    // MARK: Initialization
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    @discardableResult
    func saveBoormark(_ bookmark: NewsResults) -> NewsResults? {
        nil
    }
    
    func fetchBookmark() -> Result<[NewsResults], Error> {
        .success([])
    }
    
    @discardableResult
    func removeBookmark(_ bookmark: NewsResults) -> NewsResults? {
        nil
    }
    
    func removeAllBookmarks() {
        
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
//        guard viewContext.hasChanges else { return }
//        _ = Result(catching: viewContext.save)
//            .mapError { fatalError($0.localizedDescription) }
        
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
