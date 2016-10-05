//
//  ListEditViewController.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/04.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//
import UIKit

class ListEditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MembersDeleteCell", bundle: nil), forCellReuseIdentifier: "membersDeleteCell")
        
        let frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 0.5)
        self.tableView.tableHeaderView = UIView(frame: frame)
        self.tableView.tableHeaderView!.backgroundColor = UIColor.black
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "membersDeleteCell", for: indexPath) as! MembersDeleteCell
        
        let url = URL(string: "https://pbs.twimg.com/profile_images/734659407963815936/oxYPIVNz.jpg")!
        cell.iconImage.af_setImage(withURL: url)
        cell.name.text = "ogidow"
        return cell
    }
}
