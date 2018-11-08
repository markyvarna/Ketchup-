//
//  ProfileVC.swift
//  Ketchup
//
//  Created by Markus Varner on 10/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProfileTVCellDelegate {
   
    
  
    
    
    
    @IBOutlet var profileImgView: CircularImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var totalContactsLabel: UILabel!
    @IBOutlet var totalCallsLabel: UILabel!
    @IBOutlet var addFromContactsButton: UIButton!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var folderButton: UIButton!
    @IBOutlet var doneButton: RoundedButton!
    @IBOutlet var editStackView: UIStackView!
    @IBOutlet var contactStackView: UIStackView!
    @IBOutlet var callsStackView: UIStackView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var profBackgroundView: UIView!
    
    
    //Properties
    var numberInvited: Int?
    var contacts = ContactController.sharedContact.contacts
    var name = UserController.sharedUser.user.name
    var pickerController = UIImagePickerController()
    var user = UserController.sharedUser.user
    var currentContact: Contact?
    var phone = "00000"
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //TableView
        tableView.delegate = self
        tableView.dataSource = self
   
        totalContactsLabel.text = "\(ContactController.sharedContact.contacts.count)"
        //Image Picker
    
        pickerController.delegate = self
        //Tap Gesture, tap to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
        user = UserController.sharedUser.fetchUser()
        nameLabel.text = UserController.sharedUser.fetchUser().name!
        nameTF.text = UserController.sharedUser.fetchUser().name!
        profileImgView.image = UserController.sharedUser.convertDataToImage(data: user.avatar!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        tableView.reloadData()
    }
    
    //Initiate Video and Voice Chat Methods
    private func facetime(phoneNumber:String) {
        if let facetimeURL:NSURL = NSURL(string: "facetime://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(facetimeURL as URL)) {
                application.open(facetimeURL as URL, options: [:]) { (success) in
                    print("success")
                }
            }
        }
    }
    
    private func voiceCall(phoneNumber:String) {
        if let voiceCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(voiceCallURL as URL)) {
                application.open(voiceCallURL as URL, options: [:]) { (success) in
                    print("success")
                }
            }
        }
    }
    
    
    //MARK: - Video Chat and Voice Chat Delegate Methods
    func videoChatTapped(cell: ProfileTVCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let contact = ContactController.sharedContact.contacts[indexPath.row]
        self.phone = contact.phone!
        self.facetime(phoneNumber: self.phone)
    }
    
    func chatTapped(cell: ProfileTVCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let contact = ContactController.sharedContact.contacts[indexPath.row]
        self.phone = contact.phone!
        self.voiceCall(phoneNumber: self.phone)
    }
    
   
    //MARK: - ProfileTVCell Delegate Method
    func toggleSelectedButton(cell: ProfileTVCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let contact = ContactController.sharedContact.contacts[indexPath.row]
        
        contact.wasBlocked = !contact.wasBlocked
        ContactController.sharedContact.saveToPersistentStore()
        tableView.reloadData()
        
        print("🌇 Toggle Recieved in Profile VC")
        cell.updateView()
    }
    
    
    //MARK: - Image Picker Helper Method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            profileImgView.image = image
        }
        
        pickerController.dismiss(animated: true)
    }
    
    @IBAction func addFromContactsTapped(_ sender: UIButton) {
       presentInviteContactsAlertController()
    }
    
    
    //MARK: - Edit Profile IBActions
    @IBAction func editTapped(_ sender: UIButton) {
        
        self.editButton.isHidden = true
        self.profBackgroundView.backgroundColor = KetchupColors.tomatoRed()
        self.nameLabel.isHidden = true
        self.contactStackView.isHidden = true
        self.callsStackView.isHidden = true
        
        name = nameLabel.text!
        
        self.nameTF.isHidden = false
        self.nameTF.text = name
        self.editStackView.isHidden = false
        
    }
    
    //Camera
    @IBAction func cameraTapped(_ sender: UIButton) {
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    //Photo Library
    @IBAction func folderTapped(_ sender: UIButton) {
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    //Done Editing Profile
    @IBAction func doneTapped(_ sender: RoundedButton) {
        
        self.editButton.isHidden = false
        self.profBackgroundView.backgroundColor = UIColor.white
        self.nameLabel.isHidden = false
        self.contactStackView.isHidden = false
        self.callsStackView.isHidden = false
        

        
        self.nameTF.isHidden = true
        self.nameLabel.text = nameTF.text!
        self.editStackView.isHidden = true
        print("🌅\(nameTF.text!)")
        UserController.sharedUser.remove(aUser: self.user)
        self.user = UserController.sharedUser.updateCurrentUser(name: nameTF.text!, avatar: profileImgView.image!)
        
        
    }
    
    //Add Contacts AlertController Helper Func
    func presentInviteContactsAlertController() {
        let inviteTitle = "Ketchup!"
        let inviteMessage = "Would you like to access your Contacts."
        let inviteContactsAlertController = UIAlertController(title: inviteTitle, message: inviteMessage, preferredStyle: .alert)
        let maybeLaterAction = UIAlertAction(title: "Later", style: .cancel, handler: nil)
        let gotItAction = UIAlertAction(title: "Accept", style: .default) { (accepted) in
            
            self.performSegue(withIdentifier: "goToAddContactsVC", sender: nil)
        }
       inviteContactsAlertController.addAction(maybeLaterAction)
        inviteContactsAlertController.addAction(gotItAction)
        self.present(inviteContactsAlertController, animated: true)
    }
    
    
    
    //Tap Gesture Helper Func to Dismiss Keyboard
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return ContactController.sharedContact.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ProfileTVCell
        let contact = ContactController.sharedContact.contacts[indexPath.row]
        
        cell?.nameLabel.text = contact.firstName! + " " + contact.lastName!
        cell?.phoneLabel.text = contact.phone
        if contact.wasBlocked {
        cell?.blockUnblockButton.setImage(UIImage(named: "blockedRed"), for: .normal)
        } else {
            cell?.blockUnblockButton.setImage(UIImage(named: "checkedGreen"), for: .normal)
        }
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    //Swipe to Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let contact = ContactController.sharedContact.contacts[indexPath.row]
            ContactController.sharedContact.remove(contact: contact)
            tableView.reloadData()
        }
        
    }
    
    
}
