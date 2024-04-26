//
//  SearchVideoTableViewCell.swift
//  simulation
//
//  Created by U10916003 on 2023/8/30.
//

import UIKit

class SearchVideoTableViewCell: UITableViewCell {

    @IBOutlet var videoTitleLabel: UILabel!
    @IBOutlet var videoImage: UIImageView!
    @IBOutlet var videoChannelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
