//
//  ChatOptionController.swift
//  Ketchup
//
//  Created by Markus Varner on 10/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class ChatOptionController {
    
    static let sharedOptions = ChatOptionController()
    
    var options: [ChatOption] = [
    
        ChatOption(title: "Video Chat Roulette", image: #imageLiteral(resourceName: "womanOnPhone"), isAvailable: true, tag: 0),
        ChatOption(title: "Voice Call Roulette", image: #imageLiteral(resourceName: "voiceCall2"), isAvailable: true, tag: 1),
//        ChatOption(title: "Regular Video Chat", image: #imageLiteral(resourceName: "girlOnPhone"), isAvailable: false, tag: 2),
//        ChatOption(title: "Regular Voice Call", image: #imageLiteral(resourceName: "voiceCall"), isAvailable: false, tag: 3),
        ChatOption(title: "Messaging", image: #imageLiteral(resourceName: "guyTexting"), isAvailable: false, tag: 4),
        ChatOption(title: "Rap Battle", image: #imageLiteral(resourceName: "rapMan"), isAvailable: false, tag: 5),
        ChatOption(title: "Best Actor", image: #imageLiteral(resourceName: "actBattle"), isAvailable: false, tag: 6)
        
        
        
    ]
    
    
    
}
