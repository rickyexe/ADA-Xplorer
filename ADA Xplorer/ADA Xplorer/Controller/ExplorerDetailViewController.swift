//
//  ExplorerDetailViewController.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 01/05/21.
//

import UIKit
import CoreData

class ExplorerDetailViewController: UIViewController {
    
    @IBOutlet weak var explorerShift: UILabel!
    @IBOutlet weak var explorerTeam: UILabel!
    @IBOutlet weak var explorerExpertise: UILabel!
    @IBOutlet weak var explorerName: UILabel!
    @IBOutlet weak var explorerDescription: UILabel!
    @IBOutlet weak var explorerPicture: UIImageView!
    weak var detailExplorerDelegate : DetailExplorerDelegate?
    var explorer:Explorer!
    var result:Explorer!
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
//            insertMediaAchievement(name: explorer.Name , type: "linkedin")
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func clickInstagram(_ sender: Any) {
        if let url = URL(string: "https://instagram.com") {
//            insertMediaAchievement(name:explorer.Name , type: "instagram")
            UIApplication.shared.open(url)
        }
    }
    
    
//    func insertMediaAchievement(name: String, type : String){
//
//        if type == "instagram" {
//
//            let instagram = getInstagramAchievementStatus(name: name)
//            if instagram == true {
//                let newInstagram = SocialStalker(context: self.context)
//                newInstagram.name = name
//            }
//
//
//        }else{
//            let linkedin = getLinkedinAchievementStatus(name: name)
//            if linkedin == true {
//                let newLinkedin = LinkedinHunter(context: self.context)
//                newLinkedin.name = name
//            }
//
//        }
//
//        do{
//            try self.context.save()
//        }catch{
//            print(error)
//        }
//
//    }

//    func getInstagramAchievementStatus(name: String) -> Bool{
//
//        let request = SocialStalker.fetchRequest() as NSFetchRequest<SocialStalker>
//
//        //set the filtering
//        let predicate  = NSPredicate(format: "name CONTAINS '\(name)'")
//        request.predicate = predicate
//
//        do{
//
//            let result = try context.fetch(request)
//            if result.count == 0 {
//                return true
//            }else{
//                return false
//            }
//
//        } catch  {
//            print("error retrieving achievement")
//        }
//
//
//    }
//
//    func getLinkedinAchievementStatus(name: String) -> Bool{
//
//        do{
//            let request = LinkedinHunter.fetchRequest() as NSFetchRequest<LinkedinHunter>
//            let predicate  = NSPredicate(format: "name CONTAINS '\(name)'")
//            request.predicate = predicate
//            let result = try context.fetch(request)
//            if result.count == 0 {
//                return true
//            }else{
//                return false
//            }
//
//
//        } catch  {
//            print("error retrieving achievement")
//        }
//
//
//    }
    

}


protocol DetailExplorerDelegate:AnyObject {
    func getExplorerData()->Explorer?
}
