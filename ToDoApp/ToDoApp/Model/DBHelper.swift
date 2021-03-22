//
//  DBHelper.swift
//  ToDoApp
//
//  Created by Nitin Patil on 19/03/21.
//

import Foundation
import CoreData
import UIKit


@available(iOS 11.0, *)
class DBHelper{
    
    static var sharedInstance = DBHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func saveData(title :String, desc : String, type : String){
        
        
        var entry = [Entry]()
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Entry")
        
        var str = String()
        if let savedString  = UserDefaults.standard.value(forKey: "savedTitle"){
            str = savedString as! String
        }
        let condition = NSPredicate(format: "title == %@",str)
        
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [condition])
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            entry = try context?.fetch(fetchRequest) as! [Entry]
            if !entry.isEmpty
            {
                let objectUpdate = entry.first!
                objectUpdate.setValue(title, forKey: "title")
                objectUpdate.setValue(desc, forKey: "desc")
                objectUpdate.setValue(type, forKey: "type")
                
                do{
                    try context?.save()
                }
                catch
                {
                    print("Failed")
                }
                
            }else{
                
                let entry = NSEntityDescription.insertNewObject(forEntityName: "Entry", into: context!) as! Entry
                
                entry.title   = title
                entry.desc   = desc
                entry.type     = type
                
                do{
                    try context?.save()
                }catch{
                    print("no data")
                }
                
            }
        }
        catch
        {
            print(error)
        }
    }
    
    func getAllEntries() -> [Entry] {
        
        var entries   = [Entry]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")

        do {
            entries = try context?.fetch(fetchRequest) as! [Entry]
        } catch let error as NSError {
            print(error)
        }
        return entries
    }
    
    func deleteEntry(title:String,desc : String){
        
        var entries = [Entry]()
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Entry")
        
        let condition1 = NSPredicate(format: "title == %@",title)
        let condition2 = NSPredicate(format: "desc == %@", desc)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [condition1,condition2])
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            entries = try context?.fetch(fetchRequest) as! [Entry]
            if entries.count != 0
            {
                let entry = entries.first!
                do{
                    context?.delete(entry)
                    try context!.save()
                }
                catch
                {
                    print("Failed")
                }
            }
        }
        catch
        {
            print(error)
        }
    }
    
}
      
