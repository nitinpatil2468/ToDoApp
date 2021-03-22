//
//  TodoViewModel.swift
//  ToDoApp
//
//  Created by Nitin Patil on 19/03/21.
//

import Foundation
import CoreData

class TodoViewModel {
    
    var title = ""
    var desc  = ""
    var type = ""
    
    init(entry:Entry) {
        self.title  = entry.title!
        self.desc   = entry.desc!
        self.type = entry.type!
    }
}
