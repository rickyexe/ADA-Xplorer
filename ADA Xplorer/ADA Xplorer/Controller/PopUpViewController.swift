//
//  PopUpViewController.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 04/05/21.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var achievementDescription: UILabel!
    @IBOutlet weak var achievementTitle: UILabel!
    @IBOutlet weak var achievementImage: UIImageView!
    
    
    
    var achievement : Achievement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        achievementDescription.text = achievement.description
        achievementTitle.text = achievement.title
        achievementImage.image = UIImage(named: achievement.photo)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
