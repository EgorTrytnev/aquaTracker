//
//  TableViewCell.swift
//  GlassFish
//
//  Created by user on 08.08.2023.
//

import DropDown
import UIKit

class TableViewCell: DropDownCell {
    
    @IBOutlet var myImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myImage.contentMode = .center
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
