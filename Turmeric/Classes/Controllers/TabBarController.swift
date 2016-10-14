//
//  TabBarController.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/10/04.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let tabbar = UITabBar.appearance()
        
        tabbar.tintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tabbar.barTintColor = UIColor(red: 1.0, green: 160/255.0, blue: 0.0, alpha: 1.0)
        tabbar.unselectedItemTintColor = UIColor(red: 255/255.0, green: 236/255.0, blue: 179/255.0, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // viewControllerに切り替えるタブがタップされた際に呼ばれ、遷移するかどうかを判定
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // 投稿画面の(ダミー画面)以外は全部問題なく切り替え
        if !(viewController is DummyViewController) {
           return true
        }
        
        // 投稿画面をモーダル表示
        if let currentVC = self.selectedViewController{
            let vc = UIStoryboard(name: "Post", bundle: nil).instantiateInitialViewController()
            currentVC.present(vc!, animated: true, completion: nil)
        }
        
        // ダミー画面は表示しない
        return false
    }
}
