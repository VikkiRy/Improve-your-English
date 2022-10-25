//
//  CustomTableViewCell.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 28/09/2022.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    var dataModel = SettingsDataModel()
    
    @IBOutlet weak var checkMarkImageView: UIImageView!
    @IBOutlet weak var topicTitleLabel: UILabel!
    @IBOutlet weak var checkmarkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func checkMarkButtonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("selectedTopicsChanged"), object: sender.tag)
    }
}
