//
//  ListManagementViewController.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/07.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class ListManagementViewController: UITableViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ListDeleteCell", bundle: nil), forCellReuseIdentifier: "listDeleteCell")
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "listDeleteCell", for: indexPath) as! ListDeleteCell
        cell.name.text = "Friends"
        return cell
    }
}
