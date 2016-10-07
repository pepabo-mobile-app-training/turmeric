//
//  MemberAddCell.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/07.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class MemberAddCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var addButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
