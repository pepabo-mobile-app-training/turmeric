//
//  OthersProfileViewController.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/10/11.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class OthersProfileViewController: UIViewController {
    @IBOutlet weak var followButton: LinedButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var micropostsLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    // 遷移元のVCで、このプロパティに表示したいユーザをsetする
    var user: User? = nil
    var isFollowedByMe: Bool! = nil
    
    override func viewWillAppear(_ animated: Bool) {
        self.usernameLabel.text = self.user?.name
        
        if let micropostCount = user?.micropostsCount, let followersCount = user?.followersCount, let followingCount = user?.followingCount {
            self.micropostsLabel.text = micropostCount.description
            
            self.followersButton.setTitle(followersCount.description, for: UIControlState.normal)
            self.followingButton.setTitle(followingCount.description, for: UIControlState.normal)
        }
        
        do {
            let data = try Data(contentsOf: (user?.iconURL)! )
            self.profileImage.image = UIImage(data: data)
        } catch {
            //画像がダウンロードできなかった
        }
        
        
        // 自分がフォローしてるか取得してボタンを変更
        User.getMyUser(){ me in
            User.getFollowing(id: me.id){ following in
                self.followButton.isHidden = false    // レスポンスが来たので隠すのをやめる
                
                self.isFollowedByMe = false
                
                var title = "フォロー"
                
                following?.forEach() { followedByMe in
                    if(followedByMe.id == self.user?.id){
                        self.isFollowedByMe = true
                        title = "アンフォロー"
                        return
                    }
                }
                
                self.followButton.setTitle(title, for: UIControlState.normal)
            }
        }
    }
    
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
    
    @IBAction func followButtonDidTap(_ sender: AnyObject) {
        // フォロー/アンフォローボタンを押下
        if(self.isFollowedByMe!){
            Relationship.destroyRelationship(userID: self.user!.id){
                self.isFollowedByMe = false
                self.followButton.setTitle("フォロー", for: UIControlState.normal)
            }
        }else{
            Relationship.createRelationship(userID: self.user!.id){
                self.isFollowedByMe = true
                self.followButton.setTitle("アンフォロー", for: UIControlState.normal)
            }
        }

    }

}
