//
//  ListAddMemberViewController.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/06.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class ListAddMemberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var followings: [User] = []
    var members: [User] = []
    var selectedListId: Int = 0

    @IBOutlet weak var tableView: UITableView!

    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MembersAddCell", bundle: nil), forCellReuseIdentifier: "membersAddCell")

        User.getMyUser(){ me in
            User.getFollowing(id: me.id){ following in
                // すでにリストに追加されているユーザは取り除く
                self.followings = following!.filter() {user in
                    !self.members.contains(where: {$0.id == user.id})
                }
                self.tableView.reloadData()
            }
        }

        // テーブルの一番上に線を引く
        let frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 0.5)
        self.tableView.tableHeaderView = UIView(frame: frame)
        self.tableView.tableHeaderView!.backgroundColor = UIColor.black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        tableView.tableFooterView = UIView()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.followings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "membersAddCell", for: indexPath) as! MembersAddCell

        let followingUser = self.followings[indexPath.row]

        let url = followingUser.iconURL
        cell.iconImage.af_setImage(withURL: url)
        cell.name.text = followingUser.name

        let addButton = cell.addButton!

        //追加ボタンタップ時のコールバック設定
        addButton.addTarget(self, action: #selector(ListAddMemberViewController.addButtonTap), for: .touchDown)

        return cell
    }

    func addButtonTap(sender: UIButton, event: UIEvent) {
        if let touch = event.allTouches?.first {
            // タッチされたボタンの位置からindexPathを検出
            let point = touch.location(in: self.tableView)
            let indexPath = self.tableView.indexPathForRow(at: point)!

            let tappedUser = self.followings[indexPath.row]
            List.addMember(id: self.selectedListId, parameters: ["user_id" : tappedUser.id]) { response in
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
