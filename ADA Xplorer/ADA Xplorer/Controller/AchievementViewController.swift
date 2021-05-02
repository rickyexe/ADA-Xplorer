//
//  AchievementViewController.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 01/05/21.
//

import UIKit

class AchievementViewController: UIViewController {
    
    
    @IBOutlet weak var achievementTableView: UITableView!
    var achievements:[Achievement]!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Achievement"
        achievementTableView.dataSource = self
        achievements = [
        Achievement(title: "Social Media Stalker", progress: "3/12", description: "Access 50 explorer instagram", photo: "instagram"),
            Achievement(title: "Connect Hunter", progress: "3/12", description: "Access 50 explorer linkedin", photo: "instagram"),
            Achievement(title: "Newcomer", progress: "3/12", description: "See your first explorer detail", photo: "instagram"),
            Achievement(title: "Master of Explorer", progress: "3/12", description: "See all explorer detail", photo: "instagram"),
            Achievement(title: "All Knowing", progress: "3/12", description: "Finish all achievements", photo: "instagram"),
            
        ]
        
        
    }


}


extension AchievementViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "achievementCell") as? AchievementTableViewCell{
            cell.achievementTitle?.text = achievements[indexPath.row].title
            cell.achievementProgress?.text = achievements[indexPath.row].progress
            cell.achievementDescription?.text = achievements[indexPath.row].description
//            cell.achievementImage?.image = UIImage(named: achievements[indexPath.row].photo)
            return cell
      
        }
        return UITableViewCell()
    }
    
}
