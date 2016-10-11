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
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
