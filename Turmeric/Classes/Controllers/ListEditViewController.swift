//
//  ListEditViewController.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/04.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//
import UIKit

class ListEditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedListId: Int?
    var list: List? = nil
    var members: [User] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listNameField: UITextField!
    
    @IBAction func updateButtonTapped(_ sender: AnyObject) {
        let group = DispatchGroup.init()
        let queue = DispatchQueue.main
        
        queue.async(group: group) {
            if (self.list!.name != self.listNameField.text && self.listNameField.text != "") {
                group.enter()
                let parameters = ["list" : ["name" : self.listNameField.text!]]
                List.update(id: self.list!.id, parameters: parameters) { response in
                    print(response.name)
                    group.leave()
                }
            }
        }

        queue.async(group: group) {
            group.enter()
            print("testttest")
            group.leave()
        }
        
        group.notify(queue: queue, execute: {
            print("unwind!!!!!!")
            self.performSegue(withIdentifier: "unwind", sender: nil)
        })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MembersDeleteCell", bundle: nil), forCellReuseIdentifier: "membersDeleteCell")
        
        let frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 0.5)
        self.tableView.tableHeaderView = UIView(frame: frame)
        self.tableView.tableHeaderView!.backgroundColor = UIColor.black
        
        
        List.getList(id: self.selectedListId!) { response in
            self.list = response
            self.listNameField.text = response.name
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
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "membersDeleteCell", for: indexPath) as! MembersDeleteCell
        
        let member = self.members[indexPath.row]
        let url = URL(string: member.iconURL)!
        cell.iconImage.af_setImage(withURL: url)
        cell.name.text = member.name
        return cell
    }
}
