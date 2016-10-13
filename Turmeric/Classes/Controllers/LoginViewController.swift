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
    let messageDisplay: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (APIClient.token != nil) {
            self.performSegue(withIdentifier: "mainView", sender: self)
        }
        
        form +++ EmailRow("email") { row in
            row.title = "メールアドレス"
        }
            <<< PasswordRow("password") { row in
            row.title = "パスワード"
        }
            +++ ButtonRow("loginButton") {row in
            row.title = "ログイン"
        }.onCellSelection({cell, row in
            let emailRow: EmailRow? = self.form.rowBy(tag: "email")
            let passwordRow: PasswordRow? = self.form.rowBy(tag: "password")
            print ("tapped button")
            if let email = emailRow?.value, let password = passwordRow?.value {
                let parameters = ["user": ["email": email, "password": password]]
                User.authenticate(parameters: parameters){ response in
                    switch response {
                    case .Success:
                        print("logged in")
                        self.performSegue(withIdentifier: "mainView", sender: self)
                    case .ValidationError(let json):
                        print(json)
                    default: break
                    }
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
