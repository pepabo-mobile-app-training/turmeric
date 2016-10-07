//
//  ListAddMemberViewController.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/06.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class ListAddMemberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil) 
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MembersAddCell", bundle: nil), forCellReuseIdentifier: "membersAddCell")
        
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "membersAddCell", for: indexPath) as! MembersAddCell
        
        let url = URL(string: "https://achievement-images.teamtreehouse.com/badges_SimpleFacebook_Stage1.png")!
        cell.iconImage.af_setImage(withURL: url)
        cell.name.text = "ogidow"
        
        return cell
    }
}
