//
//  FirstSettingsTableViewCell.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 06/10/2022.
//

import UIKit

class UserDefaultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topicTitleLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
