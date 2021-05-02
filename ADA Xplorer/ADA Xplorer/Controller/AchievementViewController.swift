//
//  AchievementViewController.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 01/05/21.
//

import UIKit

class AchievementViewController: UIViewController {
    
    
    @IBOutlet weak var achievementCollectionView: UICollectionView!
    @IBOutlet weak var achievementTableView: UITableView!
    var achievements:[Achievement]!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Achievement"
        achievementCollectionView.dataSource = self
        achievements = [
        Achievement(title: "Social Media Stalker", progress: "3/12", description: "Access 50 explorer instagram", photo: "lock"),
            Achievement(title: "Connect Hunter", progress: "3/12", description: "Access 50 explorer linkedin", photo: "lock"),
            Achievement(title: "Newcomer", progress: "3/12", description: "See your first explorer detail", photo: "lock"),
            Achievement(title: "Master of Explorer", progress: "3/12", description: "See all explorer detail", photo: "lock"),
            Achievement(title: "All Knowing", progress: "3/12", description: "Finish all achievements", photo: "lock"),
            
        ]
        
        
    }


}


extension AchievementViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return achievements.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as? AchievementCollectionViewCell{
            cell.achievementTitle?.text = achievements[indexPath.row].title
            cell.achievementProgress?.text = achievements[indexPath.row].progress
            cell.achievementDescription?.text = achievements[indexPath.row].description
            cell.achievementPicture?.image = UIImage(named: achievements[indexPath.row].photo)
            return cell
      
        }
        return UICollectionViewCell()
    }
    
}
