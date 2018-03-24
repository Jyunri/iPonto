//
//  ActionHIstoryTableViewCell.swift
//  Ponto
//
//  Created by Jimy Suenaga on 26/09/17.
//  Copyright © 2017 Jimysses. All rights reserved.
//

import UIKit

class ActionHIstoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lastActionLabel: UILabel!
    @IBOutlet weak var actionTimestamp: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
