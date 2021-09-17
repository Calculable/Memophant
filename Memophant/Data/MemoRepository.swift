/**
 CRUD Interface for Memos, managed by Core Data
 */

import Foundation
import CoreData

class MemoRepository {
    
    static let shared = MemoRepository() //Singleton
    
    let containerName = "MemoModel"
    let entityName = "Memo"
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Error: \(error)")
            }
        }
        return container
    }()

    func createMemo(date: Date, content: String) {
        let memo = Memo(context: persistentContainer.viewContext)
        memo.content = content
        memo.date = date
        saveContext()
    }
    
    var readMemos: [Memo] {
        let fetchRequest: NSFetchRequest<Memo> = NSFetchRequest(entityName: entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Memo.date, ascending: false)]
        return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
    }
    
    func deleteMemo(memo: Memo) {
        persistentContainer.viewContext.delete(memo)
        saveContext()
    }
    
    func updateMemos() {
        try? persistentContainer.viewContext.save()
    }
    
    
    func deleteAllMemos() {
        readMemos.forEach { memo in
            deleteMemo(memo: memo)
        }
    }
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error)")
            }
        }
    }
    
     
    
}
