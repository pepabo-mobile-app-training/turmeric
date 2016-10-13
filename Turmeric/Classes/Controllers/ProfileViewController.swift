//
//  ProfileViewController.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/09/29.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, PerformSegueToProfileDelegate {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var micropostsLabel: UILabel!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!

    var me: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let profileFeed = self.childViewControllers[0] as! FeedViewController
        User.getMyUser(){ response in
            switch response {
            case .Success(let user):
                self.me = user
                profileFeed.endpoint = Endpoint.UsersMicroposts(self.me!.id)
                // 非同期のためユーザーを取得してendpointに値が入る前にビューがロードされてしまう
                // 簡単な対策として明示的にリロードする
                profileFeed.reloadFeed()
            default: break
            }
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        User.getMyUser(){ response in
            switch response {
            case .Success(let user):
                self.me = user
                
                self.usernameLabel.text = user.name
                
                if let micropostCount = user.micropostsCount, let followersCount = user.followersCount, let followingCount = user.followingCount {
                    self.micropostsLabel.text = micropostCount.description
                    
                    self.followersButton.setTitle(followersCount.description, for: UIControlState.normal)
                    self.followingButton.setTitle(followingCount.description, for: UIControlState.normal)
                }
                
                do {
                    let data = try Data(contentsOf: user.iconURL )
                    self.profileImage.image = UIImage(data: data)
                } catch {
                    //画像がダウンロードできなかった
                }
            default: break
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
            vc.displayStyle = UsersViewController.DisplayStyle.Following(me!.id)
            break
        case "followers":
            let vc = segue.destination as! UsersViewController
            vc.displayStyle = UsersViewController.DisplayStyle.Followers(me!.id)
            break
        default:
            break
        }
    }
    
    func performSegueToProfile(user: User) {
        //プロフィールからプロフィールに遷移しても仕方ないので遷移しない
        return
    }
}
