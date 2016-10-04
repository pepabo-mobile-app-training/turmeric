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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // viewControllerに切り替えるタブがタップされた際に呼ばれ、遷移するかどうかを判定
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // 投稿画面以外は全部問題なく切り替え
        if !(viewController is PostViewController) {
           return true
        }
        
        // 投稿画面は切り替えずにモーダルを表示
        if let currentVC = self.selectedViewController{
            currentVC.present(viewController, animated: true, completion: nil)
        }
        
        return false
    }
}
