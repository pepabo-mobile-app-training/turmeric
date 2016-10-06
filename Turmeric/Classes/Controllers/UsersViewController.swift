//
//  UsersViewController.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/10/06.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class UsersViewController: UITableViewController {

    // 遷移元のVCで、遷移前にこのプロパティを設定する
    var displayUsers: [User] = []
 
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
 */
    
    override func viewDidLoad() {
        // MembersFollow.xib のカスタムビューを基準としてターブルビューに配置する
        tableView.register(UINib(nibName: "MembersFollow", bundle: nil), forCellReuseIdentifier: "membersFollow")

        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
