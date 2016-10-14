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

    override func viewDidAppear(_ animated: Bool) {
        User.loadToken()
        if (APIClient.token != nil) {
            // すでにログインしていればホーム画面に遷移
            self.performSegue(withIdentifier: "mainView", sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        LabelRow.defaultCellUpdate = { cell, row in
            cell.contentView.backgroundColor = .red
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
            cell.textLabel?.textAlignment = .right
            
        }

        form +++ Section()
        <<< EmailRow("email") { row in
                row.title = "メールアドレス"
                let emailClosure: ((String?) -> ValidationError?)  = { value in
                    let error = ValidationError(msg: "有効なメールアドレスを入力してください。")
                    if let value = value, !value.isEmpty{
                        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,})$")
                        guard predicate.evaluate(with: value) else {
                            return error
                        }
                        return nil
                    }
                
                    return error
                }
            
                let requiredClosure: ((String?) -> ValidationError?) = {value in
                    let error = ValidationError(msg: "メールアドレスを入力してください。")
                    if let str = value {
                        return str.isEmpty ? error : nil
                    }
                    return value != nil ? nil : error
                }
            
                let emailRule = RuleClosure(closure: emailClosure)
                let requiredRule = RuleClosure(closure: requiredClosure)
 
                row.add(rule: requiredRule)
                row.add(rule: emailRule)
                row.validationOptions = .validatesOnChangeAfterBlurred
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }.onRowValidationChanged { cell, row in
                let rowIndex = row.indexPath!.row
                while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                    row.section?.remove(at: rowIndex + 1)
                }
                if !row.isValid {
                    for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
                        let labelRow = LabelRow() {
                            $0.title = validationMsg
                            $0.cell.height = { 30 }
                        }
                        row.section?.insert(labelRow, at: row.indexPath!.row + index + 1)
                    }
                }
            }
            
        <<< PasswordRow("password") { row in
            row.title = "パスワード"
            
            let requiredClosure: ((String?) -> ValidationError?) = {value in
                let error = ValidationError(msg: "パスワードを入力してください。")
                if let str = value {
                    return str.isEmpty ? error : nil
                }
                return value != nil ? nil : error
            }
            
            let requiredRule = RuleClosure(closure: requiredClosure)
            row.add(rule: requiredRule)
            
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }.onRowValidationChanged { cell, row in
                let rowIndex = row.indexPath!.row
                while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                    row.section?.remove(at: rowIndex + 1)
                }
                if !row.isValid {
                    for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
                        let labelRow = LabelRow() {
                            $0.title = validationMsg
                            $0.cell.height = { 30 }
                        }
                        row.section?.insert(labelRow, at: row.indexPath!.row + index + 1)
                    }
                }
            }
            
        +++ Section()
        <<< ButtonRow("loginButton") {row in
            row.title = "ログイン"
        }.onCellSelection({cell, row in
            
            let emailRow: EmailRow? = self.form.rowBy(tag: "email")
            let passwordRow: PasswordRow? = self.form.rowBy(tag: "password")
            let errors: [ValidationError] = (row.section?.form?.validate())!
            
            //クライアントのバリデートで引っかかったらAPIにリクエストは送らない
            if !errors.isEmpty {
                return
            }
            
            if let email = emailRow?.value, let password = passwordRow?.value {
                let parameters = ["user": ["email": email, "password": password]]
                User.authenticate(parameters: parameters){ response in
                    switch response {
                    case .Success:
                        self.performSegue(withIdentifier: "mainView", sender: self)
                    case .ValidationError(let err):
                        var section = self.form.first
                        
                        //すでにメッセージが表示されていれば削除
                        if let validationRow : LabelRow = section?.rowBy(tag: "validationMessage") {
                            let rowIndex = validationRow.indexPath!.row
                            validationRow.section?.remove(at: rowIndex)
                        }

                        // サーバ側のバリデーションメッセージを表示する
                        let labelRow = LabelRow("validationMessage") {
                            $0.title = err["message"].string
                            $0.cell.height = { 40 }
                        }
                        section?.insert(labelRow, at: 0)
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
