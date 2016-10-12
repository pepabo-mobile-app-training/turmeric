//
//  PostViewController.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/10/04.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit
import Alamofire

class PostViewController: UIViewController {
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var iconImageView: UIImageView!

    @IBAction func closeButtonDidTapped(_ sender: AnyObject) {
        postTextView.resignFirstResponder() //キーボードを非アクティブ化
        self.dismiss(animated: true, completion: nil)   //モーダルを閉じる
    }

    override func viewWillAppear(_ animated: Bool) {
        // アイコン表示
        User.getMyUser(){ response in
            switch response {
            case .Success(let user):
                do {
                    let data = try Data(contentsOf: user.iconURL )
                    self.iconImageView.image = UIImage(data: data)
                } catch {
                    //画像がダウンロードできなかった
                }
            default: break
            }            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // ページ開いたら自動フォーカス
        postTextView.becomeFirstResponder()

        // XIBファイルからカスタムビューを取得、インスタンス化
        let toolbar = UINib(nibName: "PostKeyboardToolbar", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIToolbar

        // テキスト入力の際、キーボードの上に追加で表示されるビュー
        self.postTextView.inputAccessoryView = toolbar


        let postButton: UIBarButtonItem = toolbar.items![2]

        postButton.target = self;
        postButton.action = #selector(PostViewController.postButtonDidTap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func postButtonDidTap(){

        if let postText = postTextView.text {
            let parameters: [String : Any] = ["micropost": [
                "content": postText
                ]
            ]

            Micropost.postMicropost(parameters: parameters, handler: {micropost in })

            postTextView.resignFirstResponder() //キーボードを非アクティブ化
            self.dismiss(animated: true, completion: nil)   //モーダルを閉じる
        }
    }
}
