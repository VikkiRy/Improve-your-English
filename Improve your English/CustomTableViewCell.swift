//
//  CustomTableViewCell.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 28/09/2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var topicTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
