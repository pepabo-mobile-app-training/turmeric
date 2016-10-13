//
//  OthersProfileViewController.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/10/11.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class OthersProfileViewController: UIViewController, PerformSegueToProfileDelegate {
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
        self.reloadUser(userID: user!.id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let profileFeed = self.childViewControllers[0] as! FeedViewController
        profileFeed.endpoint = Endpoint.UsersMicroposts(self.user!.id)
        profileFeed.reloadFeed()
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
            vc.displayStyle = UsersViewController.DisplayStyle.Following(user!.id)
            break

        case "followers":
            let vc = segue.destination as! UsersViewController
            
            // 次のvcにフォロワーたちを表示するように依頼
            vc.displayStyle = UsersViewController.DisplayStyle.Followers(user!.id)
            break
        default:
            break
        }
    }
    
    @IBAction func followButtonDidTap(_ sender: AnyObject) {
        // フォロー/アンフォローボタンを押下
        if(self.isFollowedByMe!){
            Relationship.destroyRelationship(userID: self.user!.id){ response in
                switch response {
                case .Success:
                    self.isFollowedByMe = false
                    self.reloadUser(userID: self.user!.id)
                default: break
                }
            }
        }else{
            Relationship.createRelationship(userID: self.user!.id){ response in
                switch response {
                case .Success:
                    self.isFollowedByMe = true
                    self.reloadUser(userID: self.user!.id)
                default: break
                }
            }
        }
    }
    
    func performSegueToProfile(user: User) {
        //プロフィールからプロフィールに遷移しても仕方ないので遷移しない
        return
    }
    
    func reloadUser(userID: Int){
        //ユーザ読み直し
        User.getUser(userID: userID) { response in
            switch response {
            case .Success(let user):
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
        
        // 自分がフォローしてるか取得してボタンを変更
        User.getMyUser(){ getMyUserResponse in
            switch getMyUserResponse {
            case .Success(let me):
                User.getFollowing(id: me.id){ getFollowingResponse in
                    switch getFollowingResponse {
                    case .Success(let following):
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
                    default: break
                        
                    }
                }
                
            default: break
            }
        }
    }

}
