//
//  SectionCell.swift
//  ToDoApp
//
//  Created by Nitin Patil on 19/03/21.
//

import UIKit

protocol SectionCellDelegateProtocol{
    func addNewTodo(type: String)
}

class SectionCell: UITableViewCell {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var title: UILabel!
    
    var cellDelegate : SectionCellDelegateProtocol?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func performAction(_ sender: UIButton) {
        cellDelegate?.addNewTodo(type: self.title.text!)
    }
}
