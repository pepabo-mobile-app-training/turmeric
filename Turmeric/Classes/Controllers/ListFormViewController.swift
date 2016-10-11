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
    override func viewDidLoad() {
        super.viewDidLoad()
        //隙間が入っていしまうので明示的にヘッダの高さを指定してあげる
        let frame = CGRect(x: 0, y: 0, width: (self.tableView?.frame.width)!, height: 0.1)
        self.tableView?.tableHeaderView = UIView(frame: frame)
        
        // Do any additional setup after loading the view, typically from a nib.
        form +++ TextRow() { row in
            row.title = "リスト名"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
