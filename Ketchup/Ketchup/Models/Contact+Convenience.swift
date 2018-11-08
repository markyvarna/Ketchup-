//
//  Contact+Convenience.swift
//  Ketchup
//
//  Created by Markus Varner on 11/5/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import Foundation
import CoreData


extension Contact {
    
    convenience init(firstName: String, lastName: String, phone: String, wasSelected: Bool, wasBlocked: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.firstName = firstName
        self.lastName = lastName
        self.wasSelected = wasSelected
        self.phone = phone
        self.wasBlocked = wasBlocked
        
    }
    
    
}
