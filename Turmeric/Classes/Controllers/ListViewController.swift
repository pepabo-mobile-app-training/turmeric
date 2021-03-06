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
    var selectedListId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        tableView.tableFooterView = UIView()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestData()
        tableView.tableFooterView = UIView()
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        switch segue.identifier! {
        case "goDetail":
            let vc = segue.destination as! ListDetailViewController
            vc.selectedListId = self.selectedListId
        default : break
        }
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

        let bgView = UIView()
        bgView.backgroundColor = UIColor(red: 1.0, green: 236/255.0, blue: 179/255.0, alpha: 1.0)
        cell.selectedBackgroundView = bgView
        
        return cell
    }
    
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        self.selectedListId = lists?[indexPath.row].id
        self.performSegue(withIdentifier: "goDetail", sender: nil)
    }
    
    @IBAction func unwindToListViewScreen(sender: UIStoryboardSegue) {
    }
    
    private func requestData(){
        User.getMyLists { response in
            switch response {
            case .Success(let lists):
                self.lists = lists
                self.tableView.reloadData()
            default: break
            }
        }
    }
}

