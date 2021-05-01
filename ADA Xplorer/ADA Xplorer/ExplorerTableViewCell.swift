//
//  ExplorerTableViewCell.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 30/04/21.
//

import UIKit

class ExplorerTableViewCell: UITableViewCell {

    

    
    
    @IBOutlet weak var explorerName: UILabel!
    
    
    @IBOutlet weak var explorerExpertise: UILabel!
    
    @IBOutlet weak var explorerShift: UILabel!
    
    
    @IBOutlet weak var explorerPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
