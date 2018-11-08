//
//  RoundedToggleButton.swift
//  Ketchup
//
//  Created by Markus Varner on 11/7/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit


class RoundedToggleButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUi()
    }
    
    
    func setUpUi() {
        
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 3.5
        
        self.layer.cornerRadius = 6
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowColor = KetchupColors.golden().cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 3
        
    }
}

