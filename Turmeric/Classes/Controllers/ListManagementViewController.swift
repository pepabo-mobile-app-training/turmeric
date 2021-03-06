//
//  ListManagementViewController.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/07.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class ListManagementViewController: UITableViewController{

    var myLists: [List] = []
    var deleteLists: [List] = []
    
    @IBAction func completeButtonTapped(_ sender: AnyObject) {
        let group = DispatchGroup.init()
        
        self.deleteLists.forEach {
            group.enter()
            List.deleteList(id: $0.id) {response in
                switch response {
                case .Success:
                    group.leave()
                default: break
                }
            }
        }
        //選択されたリストが全て削除し終わったら画面遷移する
        group.notify(queue: DispatchQueue.main, execute: {
            self.performSegue(withIdentifier: "unwind", sender: nil)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ListDeleteCell", bundle: nil), forCellReuseIdentifier: "listDeleteCell")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        User.getMyLists { response in
            switch response {
            case .Success(let lists):
                self.myLists = lists!
                self.tableView.reloadData()
            default: break
            }
        }
        
        self.tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myLists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "listDeleteCell", for: indexPath) as! ListDeleteCell
        
        cell.name.text = self.myLists[indexPath.row].name
        
        let deleteButton = cell.deleteButton!
        //削除ボタンタップ時のコールバック設定
        deleteButton.addTarget(self, action: #selector(ListManagementViewController.deleteButtonTap), for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath)!
        // セル内で削除ボタン以外がタッチされても背景を変えない
        cell.setSelected(false, animated: false)
    }
    
    func deleteButtonTap(sender: UIButton, event: UIEvent) {
        if let touch = event.allTouches?.first {
            // タッチされたボタンの位置からindexPathを検出
            let point = touch.location(in: self.tableView)
            let indexPath = self.tableView.indexPathForRow(at: point)
            let cell = self.tableView.cellForRow(at: indexPath!) as! ListDeleteCell
            
            // ボタンが押された時の処理
            if (cell.deleteButton.title(for: .normal) == "削除"){
                // 削除ボタンの該当リストをdeleteListsとして保持する
                self.deleteLists.append(self.myLists[(indexPath?.row)!])
                
                cell.selectionStyle = .none
                cell.backgroundColor = UIColor.lightGray
                cell.deleteButton.setTitle("キャンセル", for: .normal)
            } else {
                let removeIndex = self.deleteLists.index(where: {$0.id == self.myLists[(indexPath?.row)!].id})
                self.deleteLists.remove(at: removeIndex!)
                
                cell.selectionStyle = .default
                cell.backgroundColor = UIColor.white
                cell.deleteButton.setTitle("削除", for: .normal)
            }
            
        }
    }
    
    @IBAction func unwindToListManagementViewScreen(sender: UIStoryboardSegue) {
    }
}
