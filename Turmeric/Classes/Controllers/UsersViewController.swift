//
//  UsersViewController.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/10/06.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class UsersViewController: UITableViewController {

    // 遷移元のVCで、このプロパティに表示したいユーザをsetする
    var displayUsers: [User] {
        get { return self.displayUsersVal }
        
        set {
            self.displayUsersVal = newValue
            self.tableView.reloadData()      // 非同期読み込みなどする場合があるのでsetされたら再描画
        }
    }
    private var displayUsersVal: [User] = [] // displayUsersの実データ部
    
    override func viewDidLoad() {
        // MembersFollow.xib のカスタムビューを基準としてテーブルビューに配置する
        tableView.register(UINib(nibName: "MembersFollow", bundle: nil), forCellReuseIdentifier: "membersFollow")

        super.viewDidLoad()
    }
    
    // tableの要素数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayUsers.count
    }
    
    // indexPathの行のビュー
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 表示するセルを再利用して取得
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "membersFollow", for: indexPath) as! MembersFollow
        
        cell.displayUser(user: displayUsers[indexPath.row])
    
        return cell
    }
}
