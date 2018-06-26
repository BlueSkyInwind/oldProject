//
//  CardCollectionViewCell.swift
//  fxdProduct
//
//  Created by admin on 2018/6/20.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cradIconView: UIImageView!
    
    @IBOutlet weak var cardNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cradIconView.layer.cornerRadius = self.cradIconView.frame.size.width / 2
        self.cradIconView.clipsToBounds = true
    }
    func setDataSource(_ model:CreaditCardBanksListModel)  {
        cardNameLabel.text = "\(model.cardBankName ?? " ")"
        cradIconView.sd_setImage(with: URL.init(string: "\(model.logoUrl ?? "")"), placeholderImage: UIImage.init(named: "bank_load_failure"), options: .retryFailed, completed: nil)
    }
}
