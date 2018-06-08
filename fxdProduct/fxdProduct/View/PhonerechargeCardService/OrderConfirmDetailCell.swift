//
//  OrderConfirmDetailCell.swift
//  fxdProduct
//
//  Created by admin on 2018/6/6.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class OrderConfirmDetailCell: UITableViewCell {
    
    var orderModel:PhoneCardOrderModel?{
        didSet{
            setDataSource(orderModel!)
        }
    }
    
    @IBOutlet weak var paymentMethodLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var timeLimitLabel: UILabel!
    
    @IBOutlet weak var serviceFeeLabel: UILabel!
    
    @IBOutlet weak var repayDateLabel: UILabel! 
    
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
    
    func setDataSource(_ model:PhoneCardOrderModel)  {
        amountLabel.text = "¥" + "\(model.totalPrice ?? " ")"
        timeLimitLabel.text = "\(model.days ?? " ")" + "天"
        serviceFeeLabel.text = "¥" + "\(model.feeAmount ?? " ")"
        repayDateLabel.text = "\(model.repayDate ?? " ")"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
