//
//  CoreDataStack.swift
//  Ketchup
//
//  Created by Markus Varner on 11/5/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        /*the part where it says forInfoDictionaryKey: (kCFBundleNameKey as String), is gonna go and
         gonna go get the name of the App from the info.plist file*/
        let appName = Bundle.main.object(forInfoDictionaryKey: (kCFBundleNameKey as String)) as! String
        let container = NSPersistentContainer(name: appName)
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
    
}
