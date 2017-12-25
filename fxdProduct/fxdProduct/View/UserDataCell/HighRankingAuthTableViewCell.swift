//
//  HighRankingAuthTableViewCell.swift
//  fxdProduct
//
//  Created by admin on 2017/12/25.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class HighRankingAuthTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleLabel.font = UIFont.yx_systemFont(ofSize: 15)
        self.statusLabel.font = UIFont.yx_systemFont(ofSize: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
