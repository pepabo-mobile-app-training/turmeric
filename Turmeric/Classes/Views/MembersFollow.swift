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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func displayUser(user: User, following:Bool = false){
        name.text = user.name

        let title: String = following ? "アンフォロー" : "フォロー"
        button.setTitle(title, for: UIControlState.normal)

        iconImage.af_setImage(withURL: user.iconURL)
    }
}
