//
//  UserController.swift
//  Ketchup
//
//  Created by Markus Varner on 11/1/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit
import CoreData

 var mockAvatarImage = UIImage(named: "user")!.pngData()!
 var mockUserName = "User\(Int.random(in: 0...1000))"


class UserController {

    //Shared Singleton
    static let sharedUser = UserController()
    
    //Source of Truth
    var user: User = User(name: mockUserName, avatar: mockAvatarImage)
    
    
    //Create
    func createUserWith(name: String, image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        mockUserName = name
        mockAvatarImage = imageData
        self.user = User(name: name, avatar: imageData)
        saveToPersistentStore()
    }
    
    
    //Save
    func saveToPersistentStore() {
        
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was an Errro Saving to the Context : \(error)")
        }
        
    }
    
    
    //Fetch
    func fetchUser() -> User {
        
        let  request: NSFetchRequest<User> = User .fetchRequest()
        _ = NSSortDescriptor.init(key: "name", ascending: true)
        return (try? CoreDataStack.context.fetch(request))?.first ?? user
    }
    
    //Update
    func updateCurrentUser(name: String, avatar: UIImage) -> User {
        let data = avatar.jpegData(compressionQuality: 0.75)
        print("🌄\(name)")
        self.user.avatar = data!
        self.user.name = name
        saveToPersistentStore()
        self.user = User(name: name, avatar: data!)
        return self.user
    }
    
    //Convert Data
    func convertDataToImage(data: Data) -> UIImage {
        return UIImage(data: data) ?? UIImage(named: "user")!
    }
    
    //Delete Image
    func remove(aUser: User) {
        aUser.managedObjectContext?.delete(aUser)
        CoreDataStack.context.delete(aUser)
        saveToPersistentStore()
        user = fetchUser()
        
    }

}
