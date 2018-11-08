//
//  GoldenBorderImageView.swift
//  Ketchup
//
//  Created by Markus Varner on 10/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class GoldenBorderImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView() {
        self.layer.borderWidth = 2
        self.layer.borderColor = KetchupColors.golden().cgColor
        self.layer.cornerRadius = 5
    }

}
