//
//  CoreDataStack.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 16.12.2021.
//

import Foundation
import CoreData

final class CoreDataStack {

    lazy var persistentContainer: NSPersistentContainer = {
     
        let container = NSPersistentContainer(name: "CompaniesList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    
    func remove(company: CompanyModel, completion: @escaping () -> Void) {
        self.persistentContainer.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Company.uid)) = %@", company.uid.uuidString)
            if let object = try? context.fetch(fetchRequest).first {
                context.delete(object)
                do {
                    try context.save()
                    DispatchQueue.main.async { completion() }
                } catch let error as NSError {

                    print(error.localizedDescription)
                    
                }
            }
        }
    }

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
