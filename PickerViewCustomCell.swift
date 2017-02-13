//
//  PickerViewCustomCell.swift
//  PickerView
//
//  Created by Tatiana Looby on 12/02/2017.
//  Copyright © 2017 Tatiana Looby. All rights reserved.
//

import UIKit

class PickerViewCustomCell: UITableViewCell {

    @IBOutlet weak var classNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
