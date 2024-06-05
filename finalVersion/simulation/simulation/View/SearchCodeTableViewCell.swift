//
//  SearchCodeTableViewCell.swift
//  simulation
//
//  Created by U10916003 on 2023/8/11.
//

import UIKit

class SearchCodeTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var starsLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
