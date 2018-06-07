//
//  CardNumAndPasswordCell.swift
//  fxdProduct
//
//  Created by admin on 2018/6/7.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class CardNumAndPasswordCell: UITableViewCell {

    
    @IBOutlet weak var cardNumLabel: UILabel!
    
    @IBOutlet weak var cardPasswordLabel: UILabel!
    
    @IBOutlet weak var copyPasswordBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        copyPasswordBtn.layer.cornerRadius = copyPasswordBtn.frame.size.height / 2;
        copyPasswordBtn.layer.borderColor = UI_MAIN_COLOR.cgColor
        copyPasswordBtn.layer.borderWidth = 1
        copyPasswordBtn.clipsToBounds = true
    }

    @IBAction func copyPasswordBtnClick(_ sender: Any) {
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
