//
//  PostViewController.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/10/04.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    @IBOutlet weak var postTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // XIBファイルからカスタムビューを取得、インスタンス化
        let toolbar = UINib(nibName: "PostKeyboardToolbar", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIToolbar
        
        // テキスト入力の際、キーボードの上に追加で表示されるビュー
        self.postTextView.inputAccessoryView = toolbar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
