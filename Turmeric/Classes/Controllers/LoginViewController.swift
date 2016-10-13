//
//  LoginViewController.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/13.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit
import Eureka
import SwiftyJSON

class LoginViewController: FormViewController{
    let messageDisplay: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LabelRow.defaultCellUpdate = { cell, row in
            cell.contentView.backgroundColor = .red
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
            cell.textLabel?.textAlignment = .right
            
        }
        
        if (APIClient.token != nil) {
            //すでにログインしていればhomeに遷移
            self.performSegue(withIdentifier: "mainView", sender: self)
        }
        
        form +++ Section()
        <<< EmailRow("email") { row in
            row.title = "メールアドレス"
        }
        <<< PasswordRow("password") { row in
            row.title = "パスワード"
        }
        +++ Section()
        <<< ButtonRow("loginButton") {row in
            row.title = "ログイン"
        }.onCellSelection({cell, row in
            let emailRow: EmailRow? = self.form.rowBy(tag: "email")
            let passwordRow: PasswordRow? = self.form.rowBy(tag: "password")
            row.section?.form?.validate()
            
            if let email = emailRow?.value, let password = passwordRow?.value {
                let parameters = ["user": ["email": email, "password": password]]
                User.authenticate(parameters: parameters){ response in
                    switch response {
                    case .Success:
                        self.performSegue(withIdentifier: "mainView", sender: self)
                    case .ValidationError(let err):
                        print(err)
                        
                        print(err["message"].string)
                        let section = self.form.first
                        section! <<< LabelRow() {row in
                            row.title = err["message"].string
                            
                        }
                        
                        
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
