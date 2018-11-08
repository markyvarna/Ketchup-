//
//  AddContactsVC.swift
//  Ketchup
//
//  Created by Markus Varner on 11/5/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class AddContactsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, AddContactsCellDelegate {
   
    
    @IBOutlet var selectAllButton: RoundedButton!
    @IBOutlet var addSelectedButton: RoundedButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var contactsTableView: UITableView!
    
    var contactsToInvite: [Contact] = []
    var numberInvited: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ContactController.sharedContact.fetchAllContacts()
        ContactController.sharedContact.createContactsFromContactsList()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
    }
    
    //MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactController.sharedContact.contacts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "addContactsCell", for: indexPath) as? AddContactsCell
        let contact = ContactController.sharedContact.contacts[indexPath.row]
        cell?.contact = contact
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    func toggleSelectedButton(cell: AddContactsCell) {
        guard let indexPath = contactsTableView.indexPath(for: cell) else { return }
        let contact = ContactController.sharedContact.contacts[indexPath.row]
        contact.wasSelected = !contact.wasSelected
//print("🚀Add Contact Toggle Worked with name: \(contact.firstName)")
        // TODO: is cell.updateView() below here necessary?
        cell.updateView()
    }
    
    
    //MARK: - IBActions
    

    
    @IBAction func addSelectedTapped(_ sender: RoundedButton) {
        for contact in ContactController.sharedContact.contacts {
            if contact.wasSelected != true {
                ContactController.sharedContact.remove(contact: contact)
            }
            numberInvited = contactsToInvite.count
            self.performSegue(withIdentifier: "goToProfileVC3", sender: nil)
        }
    }
    
    
    @IBAction func selectAllTapped(_ sender: RoundedButton) {
        
        for contact in ContactController.sharedContact.contacts {
            contact.wasSelected = true
        }
        self.contactsTableView.reloadData()
        
    }
    
    
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProfileVC3" {
            let destinationVC = segue.destination as? ProfileVC
            destinationVC?.numberInvited = numberInvited
            destinationVC?.contacts = contactsToInvite
        }
    }
    

}
