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
    }
    func setDataSource(_ model:CreaditCardBanksListModel)  {
        cardNameLabel.text = "\(model.cardBankName ?? " ")"
        cradIconView.sd_setImage(with: URL.init(string: "\(model.logoUrl ?? "")"), placeholderImage: UIImage.init(named: "placeholderImage_Icon"), options: .refreshCached, completed: nil)
    }
}
