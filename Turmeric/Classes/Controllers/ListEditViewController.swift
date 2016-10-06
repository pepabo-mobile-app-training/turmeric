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
    var deleteMembers: [User] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listNameField: UITextField!
    
    @IBAction func updateButtonTapped(_ sender: AnyObject) {
        let group = DispatchGroup.init()
        
        if (self.list!.name != self.listNameField.text && self.listNameField.text != "") {
            group.enter()
            let parameters = ["list" : ["name" : self.listNameField.text!]]
            List.update(id: self.list!.id, parameters: parameters) { response in
                print(response.name)
                group.leave()
            }
        }

        
        self.deleteMembers.forEach{
            group.enter()
            List.deleteMember(listId: self.list!.id, memberId: $0.id) {
                group.leave()
            }
        }
        
        
        group.notify(queue: DispatchQueue.main, execute: {
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
        let deleteButton = cell.deleteButton!
        
        //削除ボタンタップ時のコールバック設定
        deleteButton.addTarget(self, action: #selector(ListEditViewController.deleteButtonTap), for: .touchDown)
        return cell
    }
    
    func deleteButtonTap(sender: UIButton, event: UIEvent) {
        if let touch = event.allTouches?.first {
            let point = touch.location(in: self.tableView)
            let indexPath = self.tableView.indexPathForRow(at: point)
            let cell = self.tableView.cellForRow(at: indexPath!) as! MembersDeleteCell
            self.deleteMembers.append(members[(indexPath?.row)!])
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.lightGray
            cell.deleteButton.isHidden = true
            print(cell.name.text)
        }
    }
    
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath)!
        // セル内で削除ボタン以外がタッチされても背景を変えない
        cell.selectionStyle = .none
    }
}
