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
    
    @IBOutlet weak var cardTypeImage: UIImageView!
    
    @IBOutlet weak var cardExplainLabel: UILabel!
    
    @IBOutlet weak var cardApplyNum: UILabel!
    
    @IBOutlet weak var cardIconWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    
    func setDataSource(_ model:CreaditCardListModel,_ isAdd:Bool)  {
        CardIconView.image = UIImage.init(named: "card_load_failure")
        obtainCardImage_Icon( URL.init(string: "\(model.cardLogoUrl ?? "")")!) {[weak self] (image) in
            let proportion = image.size.width / image.size.height
            self?.cardIconWidth.constant = (self?.CardIconView.frame.size.height)! * proportion
            self?.CardIconView.image = image
        }

        cardName.text = "\(model.cardName ?? "")"
        let cardTypeStr = "\(model.cardLevel ?? "")"
        if cardTypeStr == "金卡" {
            cardTypeImage.image = UIImage.init(named: "gold_card_icon")
        }else {
            cardTypeImage.image = UIImage.init(named: "ordinary_card_icon")
        }
        
        cardExplainLabel.text = "\(model.cardHighlights ?? "")"
        if isAdd {
            cardApplyNum.text = "\(model.applicantsCount ?? "")" + "人申请"
        }else{
            cardApplyNum.text = "\(model.applicantsCount ?? "")"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func obtainCardImage_Icon(_ imageUrl:URL,_ complication:@escaping (_ resultImage:UIImage) -> Void)  {
        SDWebImageManager.shared().loadImage(with: imageUrl, options: .retryFailed, progress: { (receivedSize, expectedSize, targetURL) in
        }) { (image, data, errpr, cacheType, finish, imageURL) in
            if image != nil {
                complication(image!)
            }
        }
    }
}
