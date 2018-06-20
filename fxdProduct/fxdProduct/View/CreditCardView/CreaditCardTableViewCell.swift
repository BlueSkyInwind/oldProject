//
//  CreaditCardTableViewCell.swift
//  fxdProduct
//
//  Created by admin on 2018/6/20.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class CreaditCardTableViewCell: UITableViewCell {

    
    @IBOutlet weak var CardIconView: UIImageView!
    
    @IBOutlet weak var cardName: UILabel!
    
    @IBOutlet weak var cardType: UILabel!
    
    @IBOutlet weak var cardExplainLabel: UILabel!
    
    @IBOutlet weak var cardApplyNum: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
