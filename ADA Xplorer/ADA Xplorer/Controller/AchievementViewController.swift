//
//  AchievementViewController.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 01/05/21.
//

import UIKit

class AchievementViewController: UIViewController {
    
    
    @IBOutlet weak var achievementCollectionView: UICollectionView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var achievements:[Achievement]!
    var master:[MasterExplorer]?
    var instagram:[SocialStalker]?
    var linkedin : [LinkedinHunter]?
    var masterCount : Int = 0
    var instagramCount : Int = 0
    var linkedinCount : Int = 0
    var allKnowingCount : Int = 0
    var masterPicture:String = ""
    var newcomerPicture: String = ""
    var newcomerProgress: String = ""
    var instagramPicture : String = ""
    var linkedinPicture : String = ""
    var allKnowingPicture : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Achievement"
        achievementCollectionView.dataSource = self
        fetchAllAchievement()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchAllAchievement()
    }
    

    
    func fetchAllAchievement(){
        
        //Fetch the data from Core Data to process
        do{
            self.master =  try context.fetch(MasterExplorer.fetchRequest())
            self.instagram = try context.fetch(SocialStalker.fetchRequest())
            self.linkedin = try context.fetch(LinkedinHunter.fetchRequest())
            setData()
            self.achievementCollectionView.reloadData()
            
            
        }catch{
         print("error retrieving achievement data")
        }

    }
    
    
    func setData(){
        
        //handle master achievement and new comer achievement
        if let masterData = master {
            masterCount = masterData.count
            if masterCount >= 111 {
                masterPicture = "search"
            }else{
                masterPicture = "lock"
            }
            
            //handle new comer
            if masterCount >= 1 {
                newcomerPicture = "baby"
                newcomerProgress = "1/1"
            }else{
                newcomerPicture = "lock"
                newcomerProgress = "0/1"
            }
            
        }
        
        
        //handle instagram achievement
        if let instagramData = instagram {
            instagramCount = instagramData.count
            if instagramCount >= 50 {
                instagramPicture = "instagram"
            }else{
                instagramPicture = "lock"
            }
        }
        
        //handle linkedin achievement
        if let linkedinData = linkedin {
            linkedinCount = linkedinData.count
            if linkedinCount >= 50 {
                linkedinPicture = "linkedin"
            }else{
                linkedinPicture = "lock"
            }
        }
        
        //handle all knowing achievement
        if linkedinCount >= 50 && instagramCount >= 50 && masterCount >= 111 {
            allKnowingCount = 1
            allKnowingPicture = "king"
        }else{
            allKnowingCount = 0
            allKnowingPicture = "lock"
        }
        
        
        
        
        
        self.achievements = [
            Achievement(title: "Newcomer", progress: newcomerProgress, description: "See your first explorer detail", photo: newcomerPicture),
            Achievement(title: "Social Media Stalker", progress: "\(instagramCount)/50", description: "Access 50 explorer instagram", photo: instagramPicture),
            Achievement(title: "Connection Hunter", progress: "\(linkedinCount)/50", description: "Access 50 explorer linkedin", photo: linkedinPicture),
            Achievement(title: "Master of Explorer", progress: "\(masterCount)/111", description: "See all explorer detail", photo: masterPicture),
            Achievement(title: "All Knowing", progress: "\(allKnowingCount)/1", description: "Finish all achievements", photo: allKnowingPicture),
            
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
