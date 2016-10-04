//
//  ListEditViewController.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/09/30.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class ListDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //この時点で初期化してあげないとエラー出てしまう
    var selectedListId: Int?
    var list: List? = nil
    var members: [User]? = nil
    
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "MembersCell", bundle: nil), forCellReuseIdentifier: "membersCell")
        List.getList(id: self.selectedListId!) { response in
            self.list = response
            self.listNameLabel.text = response.name
        }
        
        List.getMembers(id: self.selectedListId!) { response in
            self.members = [User(id: 1, name: "syuta", iconURL: "https://currry.xyz/assets/rails-c094bc3a4bf50e5bb477109e5cb0d213af27ad75b481c4df249f50974dbeefe6.png")]
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.members?.count {
            return count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "membersCell", for: indexPath as IndexPath) as! MembersCell
        
        cell.name.text = self.members?[indexPath.row].name
        
        return cell
    }
}
