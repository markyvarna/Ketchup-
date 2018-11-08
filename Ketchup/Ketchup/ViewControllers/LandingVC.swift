//
//  LandingVC.swift
//  Ketchup
//
//  Created by Markus Varner on 10/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit
import RevealingSplashView

class LandingVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    @IBOutlet var profileButton: CircularButton!
    @IBOutlet var tableView: UITableView!
    
    var chatTag: Int?
    var user = UserController.sharedUser.fetchUser()
     let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "kRed")!, iconInitialSize: CGSize(width: 150, height: 150), backgroundColor: UIColor.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        let image = UserController.sharedUser.convertDataToImage(data: user.avatar!)
        profileButton.setImage(image, for: .normal)
        
        //Revealing Splash View
        self.view.addSubview(revealingSplashView)
        revealingSplashView.animationType = .woobleAndZoomOut
        revealingSplashView.startAnimation()
        //this stops the launch screen animation
        revealingSplashView.heartAttack = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let image = UserController.sharedUser.convertDataToImage(data: user.avatar!)
        profileButton.setImage(image, for: .normal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChatOptionController.sharedOptions.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as? OptionTVCell
        
        let option = ChatOptionController.sharedOptions.options[indexPath.row]
        cell?.titleLabel.text = option.title
        cell?.backgroundImgView.image = option.image
        if option.isAvailable == true {
            cell?.statusLabel.text = " "
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToVideoChatVC" {
            let destinationvc = segue.destination as? VideoChatVC
            guard let indexPath = tableView.indexPathForSelectedRow?.row else {return}
            print("\(indexPath)")
            destinationvc?.chatOption = ChatOptionController.sharedOptions.options[indexPath]
            print("\(ChatOptionController.sharedOptions.options[indexPath].tag)")
         }
    }
    

}
