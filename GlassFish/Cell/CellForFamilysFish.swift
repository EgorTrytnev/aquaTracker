//
//  CellForFamilysFish.swift
//  GlassFish
//
//  Created by user on 22.09.2023.
//

import UIKit

class CellForFamilysFish: UITableViewCell {

    
    
    @IBOutlet var View: UIView!
    
    @IBOutlet var TextCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        View.layer.cornerRadius = 10
        
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
