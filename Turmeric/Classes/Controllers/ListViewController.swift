//
//  ViewController.swift
//  Turmeric
//
//  Created by usr0600433 on 2016/09/26.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var lists: [List]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        User.getMyLists { lists in
            self.lists = lists
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.lists?.count {
            return count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath as IndexPath)
        cell.textLabel?.text = self.lists?[indexPath.row].name
        return cell
    }
    
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goEdit", sender: nil)
    }
}

