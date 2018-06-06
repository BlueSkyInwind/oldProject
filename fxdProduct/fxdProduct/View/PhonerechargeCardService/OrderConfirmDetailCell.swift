//
//  OrderConfirmDetailCell.swift
//  fxdProduct
//
//  Created by admin on 2018/6/6.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class OrderConfirmDetailCell: UITableViewCell {
    
    
    @IBOutlet weak var paymentMethodLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var timeLimitLabel: UILabel!
    
    @IBOutlet weak var serviceFeeLabel: UILabel!
    
    @IBOutlet weak var repayDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
