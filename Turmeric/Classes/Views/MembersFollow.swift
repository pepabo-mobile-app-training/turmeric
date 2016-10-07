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
        
        iconImage.af_setImage(withURL: URL(string: user.iconURL)!)
        
        // ボタン隠しておく
        self.button.isHidden = true
        
        // 自分のフォローリストにuserが含まれてるか判定してボタンを書き換える
        User.getMyUser(){ me in
            User.getFollowing(id: me.id){ following in
                self.button.isHidden = false    // レスポンスが来たので隠すのをやめる
                
                self.isFollowedByMe = false
                var title = "フォロー"
                
                following?.forEach() { followedByMe in
                    if(followedByMe.id == user.id){
                        self.isFollowedByMe = true
                        title = "アンフォロー"
                        return
                    }
                }
                
                self.button.setTitle(title, for: UIControlState.normal)
            }
        }
    }
}
