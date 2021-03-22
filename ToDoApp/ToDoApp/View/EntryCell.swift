//
//  EntryCell.swift
//  ToDoApp
//
//  Created by Nitin Patil on 19/03/21.
//

import UIKit



class EntryCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
