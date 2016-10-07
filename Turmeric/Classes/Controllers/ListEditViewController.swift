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
        
        // リスト名が変更前後で変わっていない場合、リスト名が空文字列の場合はAPIにリクエストを発行しない
        if (self.list!.name != self.listNameField.text && self.listNameField.text != "") {
            group.enter()
            let parameters = ["list" : ["name" : self.listNameField.text!]]
            // TODO:レスポンスが返ってこない場合、無限に待ち続けるのでエラーハンドリングする
            List.update(id: self.list!.id, parameters: parameters) { response in
                group.leave()
            }
        }

        
        self.deleteMembers.forEach{
            group.enter()
            List.deleteMember(listId: self.list!.id, memberId: $0.id) {
                group.leave()
            }
        }
        
        //全てのAPIのレスポンスを受け取った後に画面遷移する
        group.notify(queue: DispatchQueue.main, execute: {
            self.performSegue(withIdentifier: "unwind", sender: nil)
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        switch segue.identifier! {
        case "goAddMember":
            let vc = segue.destination as! ListAddMemberViewController
            vc.selectedListId = self.selectedListId!
        default : break
        }
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
            // タッチされたボタンの位置からindexPathを検出
            let point = touch.location(in: self.tableView)
            let indexPath = self.tableView.indexPathForRow(at: point)
            let cell = self.tableView.cellForRow(at: indexPath!) as! MembersDeleteCell
            
            // 削除ボタンの該当ユーザをdeleteMemberとして保存する
            self.deleteMembers.append(members[(indexPath?.row)!])
            
            // 該当セルの背景をグレイにし、削除ボタンを非表示にする
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.lightGray
            cell.deleteButton.isHidden = true
        }
    }
    
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath)!
        // セル内で削除ボタン以外がタッチされても背景を変えない
        cell.selectionStyle = .none
    }
}
