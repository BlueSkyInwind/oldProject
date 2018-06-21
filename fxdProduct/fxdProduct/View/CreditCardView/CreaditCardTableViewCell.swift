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
        
        self.cardType.layer.cornerRadius = self.cardType.frame.size.height / 2
        cardType.clipsToBounds = true
        cardType.layer.borderWidth = 1
        cardType.layer.borderColor = UI_MAIN_COLOR.cgColor
    }
    
    func setDataSource(_ model:CreaditCardListModel)  {
        CardIconView.sd_setImage(with: URL.init(string: "\(model.cardLogoUrl ?? "")"), placeholderImage: UIImage.init(named: "placeholderImage_Icon"), options: .refreshCached, completed: nil)
        cardName.text = "\(model.cardName ?? "")"
        cardType.text = "\(model.cardLevelName ?? "")"
        cardExplainLabel.text = "\(model.cardHighlights ?? "")"
        cardApplyNum.text = "\(model.applicantsCount ?? "")" + "万人申请"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
