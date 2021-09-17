//
//  MemoRepository.swift
//  Memophant
//
//  Created by Jan on 16.09.21.
//

import Foundation
import CoreData

class MemoRepository {
    
    static let shared = MemoRepository()
    
    private init() {
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MemoModel")
        container.loadPersistentStores { (storeDescription, error) in
            
            if let error = error {
                fatalError("Error: \(error)")
            }
            
        }
        
            
        return container
    }()
    
    func addMemo(content: String) {
        let memo = Memo(context: persistentContainer.viewContext)
        memo.content = content
        memo.date = Date.init()
        saveContext()
    }
    
    func addMemo(date: Date, content: String) {
        let memo = Memo(context: persistentContainer.viewContext)
        memo.content = content
        memo.date = date
        saveContext()
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error)")
            }
        }
    }
    
    var allMemos: [Memo] {
        let fetchRequest: NSFetchRequest<Memo> = NSFetchRequest(entityName: "Memo")
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Memo.date, ascending: false)]
        
        return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
    }
    
    func deleteMemo(memo: Memo) {
        persistentContainer.viewContext.delete(memo)
        saveContext()
    }
    
    func updateMemo(memo: Memo) {
        try? persistentContainer.viewContext.save()
    }
    
    
    func deleteAllMemos() {
        allMemos.forEach { memo in
            deleteMemo(memo: memo)
        }
    }
    
     func readDummyMemos() -> [Memo] {
    
        
        let memo1: Memo = {
            let memo = Memo(context: persistentContainer.viewContext)
            memo.content = "Hey there! Thank you for downloading Memophant 🐘"
            memo.date = Date(timeIntervalSinceNow: -24*60*60-60)
            return memo
        }()
        
        let memo2: Memo = {
            let memo = Memo(context: persistentContainer.viewContext)
            memo.content = "I will help you to remember stuff. Just click on the ➕ Button on the top of your screen to add a new memo."
            memo.date = Date(timeIntervalSinceNow: -24*60*60-360)
            return memo
        }()
        
        let memo3: Memo = {
            let memo = Memo(context: persistentContainer.viewContext)
            memo.content = "Every memo you add is saved together with the exact date and time you created it."
            memo.date = Date(timeIntervalSinceNow: -24*60*60-660)
            return memo
        }()
        
        let memo4: Memo = {
            let memo = Memo(context: persistentContainer.viewContext)
            memo.content = "Everything you tell Memophant will stay on your 📱. But be careful ⚠️ if you loose access to your phone there is no way to recover your memos ⚠️"
            memo.date = Date(timeIntervalSinceNow: -24*60*60-960)
            return memo
        }()
        
        let memo5: Memo = {
            let memo = Memo(context: persistentContainer.viewContext)
            memo.content = "You can use Memophant in many different ways. For example to track your daily activities, to note random ideas or as a simple diary."
            memo.date = Date(timeIntervalSinceNow: -2*24*60*60)
            return memo
        }()
        
        let memo6: Memo = {
            let memo = Memo(context: persistentContainer.viewContext)
            memo.content = "You can jump between months using the arrow buttons on the bottom of your screen."
            memo.date = Date(timeIntervalSinceNow: -2*24*60*60-300)
            return memo
        }()
        
        
       
        let memo7: Memo = {
            let memo = Memo(context: persistentContainer.viewContext)
            memo.content = "By the way, did you know that elephants have incredible memories? Scientists believe it's because of their large brains. It's structure is very similiar to the structure of a human brain and it enables elephants to recognize friends or enemies even after a long period of time"
            memo.date = Date(timeIntervalSinceNow: -35*24*60*60)
            return memo
        }()
            
        
        
        let memo8: Memo = {
            let memo = Memo(context: persistentContainer.viewContext)
            memo.content = """
            Here’s to the crazy ones.
            The misfits.
            The rebels.
            The troublemakers.

            The round pegs in the square holes.
            The ones who see things differently.
            They’re not fond of rules.
            And they have no respect for the status quo.
            You can quote them, disagree with them, glorify or vilify them.
            But the only thing you can’t do is ignore them.
            Because they change things.
            They push the human race forward.
            And while some may see them as the crazy ones,
            We see genius.
            Because the people who are crazy enough to think
            they can change the world,
            Are the ones who do.
            
            (From Apple's "Think different"-Campaign)
            """
            memo.date = Date(timeIntervalSince1970: 870998400)
            return memo
        }()
        
        
        
        return [memo1, memo2, memo3, memo4, memo5, memo6, memo7, memo8]
       
        
    }
    
}
