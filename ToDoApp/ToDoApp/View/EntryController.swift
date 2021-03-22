//
//  EntryController.swift
//  ToDoApp
//
//  Created by Nitin Patil on 19/03/21.
//

import Foundation
import UIKit




class EntryController: UIViewController {

    
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    
    var addTodoVM = AddTodoViewModel()
    var model = EntryModel()

    var type = String()
    var forEditing = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    func configureUI(){
        if forEditing {
            descField.text = model.desc
            titleField.text = model.title
            UserDefaults.standard.setValue(model.title, forKey: "savedTitle")
        }
        
    }
    
    
    @IBAction func Dismiss(_ sender: Any) {
        
        self.dismiss(animated: false,completion: nil)

    }
    
    @IBAction func Save(_ sender: UIButton) {
        
         let title = titleField.text
           let desc = descField.text
        
        if title != "" || desc != ""{
            
            self.addTodoVM.desc = desc!
            self.addTodoVM.title = title!
            self.addTodoVM.type = type
            
            self.addTodoVM.saveEntry()
            self.dismiss(animated: false,completion: nil)
            
        }

    }
    
}

