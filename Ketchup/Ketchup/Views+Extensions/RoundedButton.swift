//
//  RoundedButton.swift
//  Ketchup
//
//  Created by Markus Varner on 11/5/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUi()
    }

    func setUpUi() {

        self.layer.cornerRadius = 5
        self.layer.borderWidth = 3.5
        self.layer.borderColor = KetchupColors.golden().cgColor
        
    }

}
