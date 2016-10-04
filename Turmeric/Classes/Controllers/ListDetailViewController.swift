git //
//  ListEditViewController.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/09/30.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit
import AlamofireImage

class ListDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //この時点で初期化してあげないとエラー出てしまう
    var selectedListId: Int?
    var list: List? = nil
    var members: [User] = []
    
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
            self.members = response
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "membersCell", for: indexPath) as! MembersCell
        
        let member = self.members[indexPath.row]
        let url = URL(string: member.iconURL)!
        cell.iconImage.af_setImage(withURL: url)
        cell.name.text = member.name
        
        return cell
    }
}
