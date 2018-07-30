//
//  BluetoothTableViewCell.swift
//  BluetoothApp
//
//  Created by Austin Dotto on 7/30/18.
//  Copyright © 2018 Austin Dotto. All rights reserved.
//

import UIKit

class BluetoothTableViewCell: UITableViewCell {
    @IBOutlet weak var rssiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
