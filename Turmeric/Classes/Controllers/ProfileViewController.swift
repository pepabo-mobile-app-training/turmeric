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
            
            do {
                let data = try Data(contentsOf: URL(string: user.iconURL)! )
                self.profileImage.image = UIImage(data: data)
            } catch {
                //画像がダウンロードできなかった
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueID = segue.identifier else {
            return
        }
        
        switch(segueID){
        case "following":
            let vc = segue.destination as! UsersViewController

            // 次のvcに自分のフォローユーザたちを表示するように依頼
            User.getMyUser(){ me in
                User.getFollowing(id: me.id){ following in
                    vc.displayUsers = following!
                }
            }
            break
        case "followers":
            let vc = segue.destination as! UsersViewController
            
            // 次のvcに自分のフォロワーたちを表示するように依頼
            User.getMyUser(){ me in
                User.getFollowers(id: me.id){ followers in
                    vc.displayUsers = followers!
                }
            }
            break
        default:
            break
        }
    }
}
