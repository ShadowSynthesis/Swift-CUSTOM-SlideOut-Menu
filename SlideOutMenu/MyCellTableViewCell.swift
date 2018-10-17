//
//  MyCellTableViewCell.swift
//  SlideOutMenu
//
//  Created by Yoram Soussan on 10/10/2018.
//  Copyright © 2018 Yoram Soussan. All rights reserved.
//

import UIKit

class MyCellTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
