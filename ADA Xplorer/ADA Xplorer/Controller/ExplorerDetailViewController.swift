//
//  ExplorerDetailViewController.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 01/05/21.
//

import UIKit

class ExplorerDetailViewController: UIViewController {
    
    @IBOutlet weak var explorerShift: UILabel!
    @IBOutlet weak var explorerTeam: UILabel!
    @IBOutlet weak var explorerExpertise: UILabel!
    @IBOutlet weak var explorerName: UILabel!
    @IBOutlet weak var explorerDescription: UILabel!
    @IBOutlet weak var explorerPicture: UIImageView!
    weak var detailExplorerDelegate : DetailExplorerDelegate?
    
    var explorer:Explorer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let explorer = detailExplorerDelegate?.getExplorerData(){
            explorerName.text = explorer.Name
            explorerPicture.image = UIImage(named: explorer.Photo)
            explorerShift.text = explorer.Shift
            explorerTeam.text = explorer.Team
            explorerExpertise.text = explorer.Expertise
            self.explorer = explorer
            print(explorer)
        }

    }
    
    @IBAction func clickLinkedin(_ sender: Any) {
        if let url = URL(string: "https://www.linkedin.com") {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func clickInstagram(_ sender: Any) {
        if let url = URL(string: "https://instagram.com") {
            UIApplication.shared.open(url)
        }
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


protocol DetailExplorerDelegate:AnyObject {
    func getExplorerData()->Explorer?
}
