//
//  CircularButton.swift
//  Ketchup
//
//  Created by Markus Varner on 10/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class CircularButton: UIButton {

    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 2.5
        self.layer.borderColor = KetchupColors.golden().cgColor
    }

}
