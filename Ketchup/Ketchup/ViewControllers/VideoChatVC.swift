//
//  VideoChatVC.swift
//  Ketchup
//
//  Created by Markus Varner on 10/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit


class VideoChatVC: UIViewController {
    
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var callButton: CircularButton!
    @IBOutlet var chatOptionLabel: UILabel!
    @IBOutlet var bamImageView: UIImageView!
    @IBOutlet var promptLabel: UILabel!
    
    
    var chatOption: ChatOption?
    var tag: Int = 0
    var phoneNumber = "0000000"
    var numRange: Int = ContactController.sharedContact.contacts.count
    var contacts = ContactController.sharedContact.contacts
    var animationFrames = [UIImage]()
    var timer = Timer()
    var doneAnimating = false

    var unBlockedContcts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blockCheck(contacts: contacts)
        
        bamImageView.isHidden = true
        guard let chatOption = chatOption else {return}
        tag = chatOption.tag
        if tag == 0 {
            chatOptionLabel.text = "Video Chat Roulette"
        } else if tag == 1 {
            chatOptionLabel.text = "Voice Chat Roulette"
        } else if tag == 2 {
            chatOptionLabel.text = "Regular Video Chat is coming soon!"
            callButton.isHidden = true
            promptLabel.isHidden = true
        } else if tag == 3 {
            chatOptionLabel.text = "Regular Voice Chat is coming soon!"
            callButton.isHidden = true
            promptLabel.isHidden = true
        } else if tag == 4 {
            chatOptionLabel.text = "Messaging is coming soon!"
            callButton.isHidden = true
            promptLabel.isHidden = true
        } else if tag == 5 {
            chatOptionLabel.text = "Rap Battle is coming soon!"
            callButton.isHidden = true
            promptLabel.isHidden = true
        } else if tag == 6 {
            chatOptionLabel.text = "Best Actor is coming soon!"
            callButton.isHidden = true
            promptLabel.isHidden = true
        } else {
            chatOptionLabel.text = "Coming Soon"
            callButton.isHidden = true
            promptLabel.isHidden = true
            
        }
        print("🌅\(tag)")
        if contacts.count < 1 {
            callButton.isEnabled = false
        } else if contacts.count > 1 {
            callButton.isEnabled = true
        }
    }
    
    func blockCheck(contacts: [Contact]) {
        
        for contact in contacts {
            if contact.wasBlocked == false {
                unBlockedContcts.append(contact)
            }
        }
    }

    
    //Random Number Generator
    func randomNumberFrom(contacts: [Contact])-> String {
        
        let endOfRange = contacts.count
        let randomNum = Int.random(in: 0...endOfRange-1)
        
        
        return String(describing: contacts[randomNum].phone!)
    }
    
    //Initiate FaceTime Call Func
    private func facetime(phoneNumber:String) {
        if let facetimeURL:NSURL = NSURL(string: "facetime://\(randomNumberFrom(contacts: unBlockedContcts))") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(facetimeURL as URL)) {
                application.open(facetimeURL as URL, options: [:]) { (success) in
                    print("success")
                }
            }
        }
    }
    
    private func voiceCall(phoneNumber:String) {
        if let voiceCallURL:NSURL = NSURL(string: "tel://\(randomNumberFrom(contacts: contacts))") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(voiceCallURL as URL)) {
                application.open(voiceCallURL as URL, options: [:]) { (success) in
                    print("success")
                }
            }
        }
    }
    
    func animateImages() {
        bamImageView.isHidden = true
        userImageView.isHidden = false
        
        if let image = UIImage(named: "kYellow") {
            animationFrames.append(image)
            
        }
        
        if let image = UIImage(named: "kOrange") {
            animationFrames.append(image)
            
        }
        
        if let image = UIImage(named: "kBabyBlue") {
            animationFrames.append(image)
           
        }
        
        if let image = UIImage(named: "kPurple") {
            animationFrames.append(image)
            
        }
        
        if let image = UIImage(named: "kBlue") {
            animationFrames.append(image)
            
        }
        
        if let image = UIImage(named: "kRed") {
            animationFrames.append(image)
            
        }
        
        if let image = UIImage(named: "kGreen") {
            animationFrames.append(image)
            
        }
        
        


        userImageView.animationImages = animationFrames
        userImageView.animationDuration = 3.0
        userImageView.startAnimating()
        
        
        
       
    }
   
    
    @IBAction func callTapped(_ sender: CircularButton) {
        animateImages()
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            
            self.userImageView.stopAnimating()
            self.userImageView.isHidden = true
            self.bamImageView.isHidden = false
            if self.tag == 0 {
                //Facetime Roullette
                self.facetime(phoneNumber: self.phoneNumber)
                
            } else if self.tag == 1 {
                //Voice Call Roullete
                self.voiceCall(phoneNumber: self.phoneNumber)
                
            } else if self.tag == 2 {
                //Regular Facetime
            } else if self.tag == 3 {
                //Regular Voice Call
            } else if self.tag == 4 {
                //Messaging
            } else if self.tag == 4 {
                //
            } else {
                self.facetime(phoneNumber: self.phoneNumber)
            }
        }
        
        
       
       
    }
    
 
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
