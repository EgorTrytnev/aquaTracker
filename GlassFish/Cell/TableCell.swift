//
//  TableCell.swift
//  GlassFish
//
//  Created by user on 09.04.2023.
//

import UIKit

class TableCell: UITableViewCell {
    

    @IBOutlet var ViewFil: UIView!
    
    @IBOutlet var ViewCellFish: UIImageView!
    
    @IBOutlet var TextCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
