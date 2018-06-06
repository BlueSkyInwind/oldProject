//
//  OrderConfirmInfoCell.swift
//  fxdProduct
//
//  Created by admin on 2018/6/6.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class OrderConfirmInfoCell: UITableViewCell {

    
    @IBOutlet weak var orderTypeIcon: UIImageView!
    
    @IBOutlet weak var orderTypeLabel: UILabel!
    
    @IBOutlet weak var orderPriceLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var amountDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    
    }
}
