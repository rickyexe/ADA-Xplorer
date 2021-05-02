//
//  AchievementTableViewCell.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 02/05/21.
//

import UIKit

class AchievementTableViewCell: UITableViewCell {

    
    @IBOutlet weak var achievementProgress: UILabel!
    @IBOutlet weak var achievementDescription: UILabel!
    @IBOutlet weak var achievementImage: UIImageView!
    @IBOutlet weak var achievementTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
