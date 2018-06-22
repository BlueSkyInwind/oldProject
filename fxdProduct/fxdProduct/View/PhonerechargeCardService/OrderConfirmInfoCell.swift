//
//  OrderConfirmInfoCell.swift
//  fxdProduct
//
//  Created by admin on 2018/6/6.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class OrderConfirmInfoCell: UITableViewCell {

    var orderModel:PhoneCardOrderModel?{
        didSet{
            setDataSource(orderModel!)
        }
    }
    
    var orderDetailModel:PhoneOrderDetailModel?{
        didSet{
            setDataDetailSource(orderDetailModel!)
        }
    }
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let backView = UIView.init(frame: self.contentView.bounds)
        backView.backgroundColor = UIColor.white
        let shadowView = UIView.init(frame: self.contentView.bounds)
        shadowView.setCornerRadius(8, withShadow: true, withOpacity: 0.6)
        self.contentView.addSubview(shadowView)
        self.contentView.addSubview(backView)
        self.contentView.sendSubview(toBack: backView)
        self.contentView.sendSubview(toBack: shadowView)
    }
    
    func setDataSource(_ model:PhoneCardOrderModel)  {
        orderTypeIcon.sd_setImage(with: URL(string: model.icon), placeholderImage: UIImage(named: "placeholderImage_Icon"), options: .retryFailed, completed: nil)
        orderTypeLabel.text = "\(model.cardName ?? " ")"
        numberLabel.text = "数量：" + "\(model.totalCount ?? " ")"
        orderPriceLabel.text = "售价：¥" + "\(model.cardSalePrice ?? " ")"
        amountLabel.text = "订单总额：¥" + "\(model.totalPrice ?? " ")"
        amountDetailLabel.text = "¥" + "\(model.cardSalePrice ?? " ")x\(model.totalCount ?? " ")"
    }

    func setDataDetailSource(_ model:PhoneOrderDetailModel)  {
        orderTypeIcon.sd_setImage(with: URL(string: model.smallIconUrl), placeholderImage: UIImage(named: "placeholderImage_Icon"), options: .retryFailed, completed: nil)
        orderTypeLabel.text = "\(model.phone_card_name ?? " ")"
        numberLabel.text = "数量：" + "\(model.phone_card_count ?? " ")"
        orderPriceLabel.text = "售价：¥" + "\(model.phone_card_price ?? " ")"
        amountLabel.text = "订单总额：¥" + "\(model.order_price ?? " ")"
        amountDetailLabel.text = "¥" + "\(model.phone_card_price ?? " ")x\(model.phone_card_count ?? " ")"
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
