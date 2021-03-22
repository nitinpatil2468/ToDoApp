//
//  TodoListViewModel.swift
//  ToDoApp
//
//  Created by Nitin Patil on 19/03/21.
//


import Foundation
import SwiftUI



class TodoListViewModel : ObservableObject {
    
    var entries   = [TodoViewModel]()

    
    init() {
        fetchAllEntries()
    }
    
    var array  : [[EntryModel]]?

    
    func fetchAllEntries() {
        self.entries  = DBHelper.sharedInstance.getAllEntries().map(TodoViewModel.init)
        print(self.entries)
        setData(entries: self.entries)
    }
    
    func setData(entries : [TodoViewModel]){
        
        array = [[EntryModel]]()
        
        var todaysEntries = [EntryModel]()
        var tommorrowEntries = [EntryModel]()
        var upcomingEntries = [EntryModel]()
        
            for entry in entries{
  
                if entry.type == "Today"{
                    
                    let entry = EntryModel(title: entry.title, desc: entry.desc, type: entry.type)
                    todaysEntries.append(entry)
                    print("today : \(todaysEntries)")
                }
                
                if entry.type == "Tommorow"{
                    
                    let entry = EntryModel(title: entry.title, desc: entry.desc, type: entry.type)
                    tommorrowEntries.append(entry)
                    print("tommorrowEntries : \(tommorrowEntries)")

                }
                
                if entry.type == "Upcoming"{
                    
                    let entry = EntryModel(title: entry.title, desc: entry.desc, type: entry.type)
                    upcomingEntries.append(entry)
                    print("upcomingEntries : \(upcomingEntries)")
                }
            }
        
         array = [todaysEntries,tommorrowEntries,upcomingEntries]
        
    }
    
    func deleteTodo(viewModel:TodoViewModel) {
        DBHelper.sharedInstance.deleteEntry(title: viewModel.title, desc: viewModel.desc)
        fetchAllEntries()
    }
}
