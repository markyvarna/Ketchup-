//
//  User+Convenience.swift
//  Ketchup
//
//  Created by Markus Varner on 11/5/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit
import CoreData


extension User {

    convenience init(name: String, avatar: Data, context: NSManagedObjectContext = CoreDataStack.context) {

        self.init(context: context)
        self.name = name
        self.avatar = avatar
       

    }

}
