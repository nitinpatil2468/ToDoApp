//
//  AddTodoViewModel.swift
//  ToDoApp
//
//  Created by Nitin Patil on 19/03/21.
//

import Foundation

class AddTodoViewModel {
    
    var title   : String = ""
    var desc    : String = ""
    var type : String = ""

    
    func saveEntry(){
        DBHelper.sharedInstance.saveData(title : self.title, desc : self.desc, type: self.type)
    }
}
