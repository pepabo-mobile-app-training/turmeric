//
//  MembersFollow.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/10/06.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class MembersFollow: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var name: UILabel!
    
    var isFollowedByMe: Bool!
    var user: User! // このセルに表示しているユーザ
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func displayUser(user: User){
        name.text = user.name
        
        iconImage.af_setImage(withURL: user.iconURL)
        
        // ボタン隠しておく
        self.button.isHidden = true
        
        // ユーザを覚えておく
        self.user = user
        
        // 自分のフォローリストにuserが含まれてるか判定してボタンを書き換える
        User.getMyUser(){ getMyUserResponse in
            switch getMyUserResponse {
            case .Success(let me):
                User.getFollowing(id: me.id){ response in
                    self.button.isHidden = false    // レスポンスが来たので隠すのをやめる
                    
                    self.isFollowedByMe = false
                    
                    var title = "フォロー"
                    switch response {
                    case .Success(let following):
                        following?.forEach() { followedByMe in
                            if(followedByMe.id == user.id){
                                self.isFollowedByMe = true
                                title = "アンフォロー"
                                return
                            }
                        }
                        self.button.setTitle(title, for: UIControlState.normal)
                    default: break
                    }
                }
            default: break
            }
        }
    }
    
    // フォロー/アンフォローボタン押下
    @IBAction func followButtonDidTap(_ sender: AnyObject) {
        if(self.isFollowedByMe!){
            Relationship.destroyRelationship(userID: user.id){ response in
                switch response {
                case .Success:
                    self.isFollowedByMe = false
                    self.button.setTitle("フォロー", for: UIControlState.normal)
                default: break
                }
                
            }
        }else{
            Relationship.createRelationship(userID: user.id){ response in
                switch response {
                case .Success:
                    self.isFollowedByMe = true
                    self.button.setTitle("アンフォロー", for: UIControlState.normal)
                default: break
                }
                
            }
        }
    }
}
