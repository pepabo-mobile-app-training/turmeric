//
//  ListEditViewController.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/09/30.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class ListDtailViewController: UIViewController {
    
    var selectedListId: Int?
    
    //@IBOutlet weak var listLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  listLabel.text = String("リストID" + String(describing: selectedListId))
        print(selectedListId)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
