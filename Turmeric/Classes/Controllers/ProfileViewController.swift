//
//  ProfileViewController.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/09/29.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var micropostsLabel: UILabel!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    //var followingButton: UIButton
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        User.getMyUser(){ user in
            self.usernameLabel.text = user.name
            
            if let micropostCount = user.micropostsCount, let followersCount = user.followersCount, let followingCount = user.followingCount {
                self.micropostsLabel.text = micropostCount.description
                
                self.followersButton.setTitle(followersCount.description, for: UIControlState.normal)
                self.followingButton.setTitle(followingCount.description, for: UIControlState.normal)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
