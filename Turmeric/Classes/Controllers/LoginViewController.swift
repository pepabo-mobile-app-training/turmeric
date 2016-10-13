//
//  LoginViewController.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/13.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit
import Eureka

class LoginViewController: FormViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ TextRow("listName") { row in
            row.title = "メールアドレス"
        }
            <<< PasswordRow("password") { row in
            row.title = "パスワード"
        }
            +++ ButtonRow() {row in
            row.title = "ログイン"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
