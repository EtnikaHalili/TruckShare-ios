//
//  OrdersTableViewCell.swift
//  OrderApp
//
//  Created by Majlinda - INNO on 25.6.21.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainContainer.showShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
