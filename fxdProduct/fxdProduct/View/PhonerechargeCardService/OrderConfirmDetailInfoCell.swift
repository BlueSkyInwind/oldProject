//
//  OrderConfirmDetailInfoCell.swift
//  fxdProduct
//
//  Created by admin on 2018/6/6.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class OrderConfirmDetailInfoCell: UITableViewCell {

    
    @IBOutlet weak var orderSerialNumberLabel: UILabel!
    
    @IBOutlet weak var payTimeLabel: UILabel!
    
    @IBOutlet weak var payType: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var serviceFeeLabel: UILabel!
    
    @IBOutlet weak var orderPeriodLabel: UILabel!
    
    @IBOutlet weak var repayDateLabel: UILabel!
    
    @IBOutlet weak var protocolBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let shadowView = UIView.init(frame: self.bounds)
        shadowView.setCornerRadius(8, withShadow: true, withOpacity: 0.6)
        self.contentView.addSubview(shadowView)
        self.contentView.sendSubview(toBack: shadowView)
    }
    
    @IBAction func protocolButtonClick(_ sender: UIButton) {
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
