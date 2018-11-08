//
//  ProfileTVCell.swift
//  Ketchup
//
//  Created by Markus Varner on 10/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

protocol ProfileTVCellDelegate: class {
    func toggleSelectedButton(cell: ProfileTVCell)
    func videoChatTapped(cell: ProfileTVCell)
    func chatTapped(cell: ProfileTVCell)
}

class ProfileTVCell: UITableViewCell {

    @IBOutlet var contactImgView: CircularImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var blockUnblockButton: UIButton!
    @IBOutlet var chatButton: UIButton!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var videoChatButton: UIButton!
    
    var contact: Contact? {
        didSet{
            updateView()
        }
    }
    
    weak var delegate: ProfileTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateView() {
         print("🎆 Toggle recieved in updatview func in cell")
        guard let contact = contact else {return}
        if contact.wasBlocked {
            blockUnblockButton.setImage(UIImage(named: "blockedRed"), for: .normal)
        } else {
            blockUnblockButton.setImage(UIImage(named: "checkedGreen"), for: .normal)
        }
        
        print("🎆 Toggle recieved in updatview func in cell")
    }
    
    @IBAction func blockUnblockTapped(_ sender: UIButton) {
        
        delegate?.toggleSelectedButton(cell: self)
    }
    
    @IBAction func chatTapped(_ sender: UIButton) {
        
        delegate?.chatTapped(cell: self)
    }
    
    @IBAction func videoChatTapped(_ sender: UIButton) {
        delegate?.videoChatTapped(cell: self)
        
    }
    
}
