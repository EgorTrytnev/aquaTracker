//
//  KindFishCell.swift
//  GlassFish
//
//  Created by user on 28.10.2023.
//

import UIKit

class KindFishCell: UITableViewCell {
    
    @IBOutlet var myImage: UIImageView!
    @IBOutlet var fishName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        myImage.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
