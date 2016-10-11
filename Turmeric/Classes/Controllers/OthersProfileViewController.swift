//
//  OthersProfileViewController.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/10/11.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class OthersProfileViewController: UIViewController {
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var micropostsLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    // 遷移元のVCで、このプロパティに表示したいユーザをsetする
    var user: User? {
        set {
            self.userVal = newValue
            
            self.usernameLabel.text = newValue?.name
            
            if let micropostCount = newValue?.micropostsCount, let followersCount = newValue?.followersCount, let followingCount = newValue?.followingCount {
                self.micropostsLabel.text = micropostCount.description
                
                self.followersButton.setTitle(followersCount.description, for: UIControlState.normal)
                self.followingButton.setTitle(followingCount.description, for: UIControlState.normal)
            }
            
            do {
                let data = try Data(contentsOf: (newValue?.iconURL)! )
                self.profileImage.image = UIImage(data: data)
            } catch {
                //画像がダウンロードできなかった
            }
        }
        
        get {
            return self.userVal
        }
    }
    private var userVal: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            
            // 次のvcにフォローユーザたちを表示するように依頼
            User.getFollowing(id: user!.id){ following in
                vc.displayUsers = following!
            }
            break
        case "followers":
            let vc = segue.destination as! UsersViewController
            
            // 次のvcにフォロワーたちを表示するように依頼
            User.getFollowers(id: user!.id){ followers in
                vc.displayUsers = followers!
            }
            break
        default:
            break
        }
    }

}
