//
//  PositionTableViewCell.swift
//  请求类
//
//  Created by KingSoft on 2017/7/5.
//  Copyright © 2017年 KingSoft. All rights reserved.
//

import UIKit

class PositionTableViewCell: UITableViewCell {
    @IBOutlet weak var positionLB: UILabel!
    @IBOutlet weak var companyLB: UILabel!
    @IBOutlet weak var wageLB: UILabel!
    @IBOutlet weak var addressLB: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func refreshUI(model:PositionModel){
//        self.positionLB.text? = "asdasd"
        positionLB.text = model.zwmc
        companyLB.text = model.qymc
        wageLB.text = model.Yx
        addressLB.text = model.gzdd
    }

}
