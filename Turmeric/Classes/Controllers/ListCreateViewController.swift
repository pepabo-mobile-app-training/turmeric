//
//  ListCreateViewController.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/11.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class ListCreateViewController: UIViewController {
    var formController: ListFormViewController!
    
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        //リスト名が空の場合は何もしない
        if (formController.listName == "") {
            return
        }
        
        let parameters = ["list" : ["name" : formController.listName]]
        
        List.createList(parameters: parameters) { response in
            self.performSegue(withIdentifier: "unwind", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        formController = self.childViewControllers.first as! ListFormViewController
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
