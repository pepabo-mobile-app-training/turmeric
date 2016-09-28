//
//  LinedButton.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/09/28.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit.UIButton

class LinedButton: UIButton {
    override func draw(_ rect: CGRect) {
        // 角丸
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        // 枠線
        self.layer.borderColor = self.currentTitleColor.cgColor //文字色と一致させる
        self.layer.borderWidth = 1
        
        super.draw(rect)
    }
}
