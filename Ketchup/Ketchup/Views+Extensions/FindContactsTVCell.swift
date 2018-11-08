//
//  FindContactsTVCell.swift
//  Ketchup
//
//  Created by Markus Varner on 10/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class FindContactsTVCell: UITableViewCell {
    
    
    
    @IBOutlet var contactImgView: CircularImageView!
    @IBOutlet var contactNameLabel: UILabel!
    @IBOutlet var addContactButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    @IBAction func addContactTapped(_ sender: UIButton) {
        
        
    }
    
}
