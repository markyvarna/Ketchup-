//
//  ChatOption.swift
//  Ketchup
//
//  Created by Markus Varner on 10/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class ChatOption {
    
    var title: String
    var image: UIImage
    var isAvailable: Bool
    var tag: Int
    
    init(title: String, image: UIImage, isAvailable: Bool, tag: Int) {
        self.title = title
        self.image = image
        self.isAvailable = isAvailable
        self.tag = tag
    }
    
    
}


