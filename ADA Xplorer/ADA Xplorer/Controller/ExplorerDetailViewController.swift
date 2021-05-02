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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let explorer = detailExplorerDelegate?.getExplorerData(){
            explorerName.text = explorer.Name
            explorerPicture.image = UIImage(named: explorer.Photo)
            explorerShift.text = explorer.Shift
            explorerTeam.text = explorer.Team
            explorerExpertise.text = explorer.Expertise
            self.explorer = explorer
        }

    }
    
    @IBAction func clickLinkedin(_ sender: Any) {
        if let url = URL(string: "https://www.linkedin.com") {
            insertMediaAchievement(name: explorer.Name , type: "linkedin")
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func clickInstagram(_ sender: Any) {
        if let url = URL(string: "https://instagram.com") {
            insertMediaAchievement(name:explorer.Name , type: "instagram")
            UIApplication.shared.open(url)
        }
    }
    
    
    func insertMediaAchievement(name: String, type : String){
        
        if type == "instagram" {
            let newInstagram = SocialStalker(context: self.context)
            newInstagram.name = name
        }else{
            let newLinkedin = LinkedinHunter(context: self.context)
            newLinkedin.name = name
        }
    
        do{
            try self.context.save()
        }catch{
            print(error)
        }
    
    }
    
    func insertLinkedin(name : String){
       
    }

}


protocol DetailExplorerDelegate:AnyObject {
    func getExplorerData()->Explorer?
}
