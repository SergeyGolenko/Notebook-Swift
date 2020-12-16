//
//  CustomCellTableViewCell.swift
//  NotebookSwift
//
//  Created by Сергей Голенко on 16.12.2020.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mounthDate: UILabel!
    @IBOutlet weak var numberDate: UILabel!
    @IBOutlet weak var myTextLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
