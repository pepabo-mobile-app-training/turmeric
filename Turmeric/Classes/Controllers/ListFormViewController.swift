//
//  FormViewController.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/11.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit
import Eureka

class ListFormViewController:  FormViewController{
    
    var listName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //隙間が入ってしまうので明示的にヘッダの高さを指定してあげる
        let frame = CGRect(x: 0, y: 0, width: (self.tableView?.frame.width)!, height: 0.1)
        self.tableView?.tableHeaderView = UIView(frame: frame)
        
        // Do any additional setup after loading the view, typically from a nib.
        form +++ TextRow("listName") { row in
            row.title = "リスト名"
        }.onChange{ row in
            if let value = row.value {
                self.listName = value as String
            } else {
                self.listName = ""
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // リスト名入力フォームにフォーカスをあてて、はじめからキーボードを出しておく
        let listName = self.form.rowBy(tag: "listName") as! TextRow
        listName.cell.textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
