//
//  ViewController.swift
//  Turmeric
//
//  Created by usr0600433 on 2016/09/26.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath as IndexPath)
        cell.textLabel?.text = "test"
        return cell
    }
}

