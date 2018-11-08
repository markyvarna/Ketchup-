//
//  ContactController.swift
//  Ketchup
//
//  Created by Markus Varner on 10/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit
import Contacts
import CoreData

class ContactController {
    
    static let sharedContact = ContactController()
    private init() {
        contacts = fetchContacts()
    }
    
    var contacts: [Contact] = []
    
    var results: [CNContact] = []
    
    //Fetch Contacts Func
    func fetchAllContacts() {
        
        let contactsFetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor])
        contactsFetchRequest.sortOrder = CNContactSortOrder.familyName
        let store = CNContactStore()
        do {
            try store.enumerateContacts(with: contactsFetchRequest, usingBlock: { (contact, stop) in
//                print(contact.phoneNumbers.first?.value ?? "no phone numbers fetched")
                self.results.append(contact)
            })
        } catch let error as NSError {
            print("Error fetching all contacts \(error.localizedDescription)")
        }
    }
    
    
    
    
    //Create Contact
    func createContactsFromContactsList() {
        
        for result in results {
            let firstName = result.givenName
            let lastName = result.familyName
            if !result.phoneNumbers.isEmpty {
                let phone = (result.phoneNumbers[0].value).value(forKey: "digits") as! String
                add(contactWithName: firstName, lastName: lastName, phone: phone, wasSelected: false, wasBlocked: false)
                
            }
            
//            let newContact = Contact(firstName: firstName, lastName: lastName, phone: phone, wasSelected: false)
            contacts = fetchContacts()
            saveToPersistentStore()
        }

    }
    
    //MARK: - CoreData Functions
    
    //Add
    func add(contactWithName firstName: String, lastName: String, phone: String, wasSelected: Bool, wasBlocked: Bool ) {
        let _ = Contact(firstName: firstName, lastName: lastName, phone: phone, wasSelected: wasSelected, wasBlocked: wasBlocked)
        
        saveToPersistentStore()
        contacts = fetchContacts()
    }
    
    //SAVE
    func saveToPersistentStore() {
        
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was an Errro Saving to the Context : \(error)")
        }
        
    }
    
    //Fetch
    func fetchContacts() -> [Contact] {
        
        let  request: NSFetchRequest<Contact> = Contact.fetchRequest()
        _ = NSSortDescriptor.init(key: "firstName", ascending: true)
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    //Update
    func update(contact: Contact, firstName: String, lastName: String, phone: String, wasSelected: Bool, wasBlocked: Bool) -> [Contact] {
        contact.firstName = firstName
        contact.lastName = lastName
        contact.wasSelected = wasSelected
        contact.phone = phone
        contact.wasBlocked = wasBlocked
        
        saveToPersistentStore()
        contacts = fetchContacts()
        
        return contacts
    }
    
    //Delete
    func remove(contact: Contact) {
        contact.managedObjectContext?.delete(contact)
        CoreDataStack.context.delete(contact)
        saveToPersistentStore()
        contacts = fetchContacts()
        
    }
    
}



