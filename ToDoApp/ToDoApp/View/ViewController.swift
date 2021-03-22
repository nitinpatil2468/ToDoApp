//
//  ViewController.swift
//  ToDoApp
//
//  Created by Nitin Patil on 18/03/21.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    var viewModel  : TodoListViewModel?
    
    var array  = [[EntryModel]]()
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = TodoListViewModel()
        configureUI()
        updateUI()

    }
    
    func configureUI(){
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel = TodoListViewModel()
        updateUI()
    }
    
    func updateUI() {
        
        array = (self.viewModel?.array)!
        table.reloadData()
    }
}


extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("Section : \(section)")
        print("array : \(array)")
        
        if array.count == 0 {
            return 1
        }else{
            if array[section].count == 0{
                return 1
            }else{
                return array[section].count + 1
            }
        }

       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SectionCell
                cell.title.text = "Today"
                cell.cellDelegate = self
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "entry", for: indexPath) as! EntryCell
                
                cell.title.text = array[0][indexPath.row - 1].title
                return cell
            }
            
        }else if indexPath.section == 1 {
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SectionCell
                cell.title.text = "Tommorow"
                cell.cellDelegate = self
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "entry", for: indexPath) as! EntryCell
                cell.title.text = array[1][indexPath.row - 1].title
                return cell
            }
        }else if indexPath.section == 2 {
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SectionCell
                cell.title.text = "Upcoming"
                cell.cellDelegate = self
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "entry", for: indexPath) as! EntryCell
                cell.title.text = array[2][indexPath.row - 1].title
                return cell
            }
        }else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row > 0{

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc   = storyboard.instantiateViewController(withIdentifier: "entry") as! EntryController
        vc.model = array[indexPath.section][indexPath.row - 1]
        vc.forEditing = true
            
            let indexPath = IndexPath(row: 0, section: indexPath.section)
            let cell = table.cellForRow(at: indexPath) as! SectionCell
            print(cell.title.text!)
            vc.type = cell.title.text!

        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: false, completion: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let delete = UITableViewRowAction(style: .destructive, title: "delete") { (action, indexPath) in
            if indexPath.row > 0{
                
                self.table.beginUpdates()
                self.array[indexPath.section].remove(at: indexPath.row - 1)
                    let arr : [IndexPath] = [indexPath]
                self.table.deleteRows(at: arr, with: .fade)
                guard let todo = self.viewModel?.entries[indexPath.row - 1] else {return}
                self.viewModel?.deleteTodo(viewModel: todo)
                self.table.endUpdates()

            }
        }
        return [delete]
    }


}

extension ViewController : SectionCellDelegateProtocol{
    
    func addNewTodo(type : String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc   = storyboard.instantiateViewController(withIdentifier: "entry") as! EntryController
        
        vc.type = type
        vc.forEditing = false

        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: false, completion: nil)
    }

}



