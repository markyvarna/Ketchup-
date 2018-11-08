//
//  OptionTVCell.swift
//  Ketchup
//
//  Created by Markus Varner on 10/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class OptionTVCell: UITableViewCell {

    
    
    @IBOutlet var backgroundImgView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundImgView.clipsToBounds = true
        self.backgroundImgView.contentMode = .scaleAspectFill
        self.heightAnchor.constraint(equalToConstant: 166)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
