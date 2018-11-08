//
//  AddContactsCell.swift
//  Ketchup
//
//  Created by Markus Varner on 11/5/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

protocol AddContactsCellDelegate: class {
    
    func toggleSelectedButton(cell: AddContactsCell)
}

class AddContactsCell: UITableViewCell {
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var toggleButton: RoundedToggleButton!
    
    
    var contact: Contact? {
        didSet{
            updateView()
        }
    }
    
    weak var delegate: AddContactsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateView() {
        
        guard let contact = contact,
            let firstName = contact.firstName,
            let lastName = contact.lastName else { return }
        
        nameLabel.text = firstName + " " + lastName
        
        if contact.wasSelected {
            toggleButton.setImage(UIImage(named: "checkedGreen")?.withRenderingMode(.alwaysTemplate), for: .normal)
//            ContactController.sharedContact.add(contactWithName: firstName, lastName: lastName, phone: phone, wasSelected: true)
        } else {
            toggleButton.setImage(UIImage(named: "question")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }

    
    @IBAction func toggleWasTapped(_ sender: RoundedToggleButton) {
        delegate?.toggleSelectedButton(cell: self)
        
    }
    
}
