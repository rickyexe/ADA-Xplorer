//
//  ExplorerDetailViewController.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 01/05/21.
//

import UIKit
import CoreData

class ExplorerDetailViewController: UIViewController {
    

    
    @IBOutlet weak var explorerTeam: UILabel!
    
    @IBOutlet weak var explorerDescription: UILabel!
    
    @IBOutlet weak var explorerPicture: UIImageView!
    
    @IBOutlet weak var explorerShift: UILabel!
    @IBOutlet weak var explorerExpertise: UILabel!
    @IBOutlet weak var explorerName: UILabel!
    @IBOutlet weak var personalNotesExplorer: UITextView!
    
    
    
    weak var detailExplorerDelegate : DetailExplorerDelegate?
    var explorer:Explorer!
    var result:Explorer!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var achTitle: String = ""
    var achDesc: String = ""
    var achFoto : String = ""
    
    //for achievement count
    var master:[MasterExplorer]?
    var instagram:[SocialStalker]?
    var linkedin : [LinkedinHunter]?
    var statusAchievement : Bool = false
    
    //for achievement progress
    var masterCount : Int = 0
    var instagramCount : Int = 0
    var linkedinCount : Int = 0
    var newComerCount : Int = 0
    
    //var notes
    var notesResult : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let explorer = detailExplorerDelegate?.getExplorerData(){
            explorerName.text = explorer.Name
            explorerPicture.image = UIImage(named: explorer.Photo)
            explorerShift.text = explorer.Shift
            explorerTeam.text = explorer.Team
            explorerExpertise.text = explorer.Expertise
            explorerDescription.text = "Hello my name is \(explorer.Name). Check out my social media and let's get to know each other"
            self.explorer = explorer
        }
        navigationItem.title = "Explorer Detail"
        explorerPicture.layer.cornerRadius = 20
        checkAchievementCompletion(tipe: "newcomer")
        checkAchievementCompletion(tipe: "allknowing")
        checkAchievementCompletion(tipe: "master")
        
        notesResult = getProfileNotes(name: explorer.Name)
        personalNotesExplorer.text = notesResult
        
        
    
    }

    
    @IBAction func saveNotes(_ sender: Any) {
        
        
        if personalNotesExplorer.text == "" {
            showAlert(title: "Alert", message: "Come on, don't leave it in blank")
            
        }else{
            if addNewNotes(name: explorer.Name, notes: personalNotesExplorer.text) == true{
                showAlert(title: "Success", message: "Notes saved succesfully")
            }else{
                showAlert(title: "Error", message: "Failed to save notes, please try again")
            }
        }
        
        
        
   
    }
    
    
    
    
    @IBAction func clickInstagram(_ sender: Any) {
        if let url = URL(string: "https://instagram.com/uc_appledeveloperacademy") {
            insertMediaAchievement(name:explorer.Name , type: "instagram")
            checkAchievementCompletion(tipe: "instagram")
            UIApplication.shared.open(url)
        }
    }
    
    
    @IBAction func clickLinkedin(_ sender: Any) {
        if let url = URL(string: "https://www.linkedin.com/company/apple-developer-academy-uc/mycompany/") {
            insertMediaAchievement(name: explorer.Name , type: "linkedin")
            checkAchievementCompletion(tipe: "linkedin")
            UIApplication.shared.open(url)
        }
    }
    
    func insertMediaAchievement(name: String, type : String){

        if type == "instagram" {

            let instagram = getInstagramAchievementStatus(name: name)
            if instagram == true {
                let newInstagram = SocialStalker(context: self.context)
                newInstagram.name = name
            }


        }else{
            let linkedin = getLinkedinAchievementStatus(name: name)
            if linkedin == true {
                let newLinkedin = LinkedinHunter(context: self.context)
                newLinkedin.name = name
            }

        }

        do{
            try self.context.save()
        }catch{
            print(error)
        }

    }

    func getInstagramAchievementStatus(name: String) -> Bool{

        let request = SocialStalker.fetchRequest() as NSFetchRequest<SocialStalker>

        //set the filtering
        let predicate  = NSPredicate(format: "name CONTAINS '\(name)'")
        request.predicate = predicate

        do{

            let result = try context.fetch(request)
            if result.count == 0 {
                return true
            }else{
                return false
            }

        } catch  {
            print("error retrieving achievement")
        }
        
        
        return false;


    }

    func getLinkedinAchievementStatus(name: String) -> Bool{

        do{
            let request = LinkedinHunter.fetchRequest() as NSFetchRequest<LinkedinHunter>
            let predicate  = NSPredicate(format: "name CONTAINS '\(name)'")
            request.predicate = predicate
            let result = try context.fetch(request)
            if result.count == 0 {
                return true
            }else{
                return false
            }


        } catch  {
            print("error retrieving achievement")
        }
        
        return false;
        

    }
    
    
    func getProfileNotes(name: String) -> String{
        
        do{
            let request = ExplorerNotes.fetchRequest() as NSFetchRequest<ExplorerNotes>
            let predicate  = NSPredicate(format: "name == '\(name)'")
            request.predicate = predicate
            let result = try context.fetch(request)
            if result.count == 0 {
                return ""
            }else{
                return result[result.count - 1].notes ?? ""
            }


        } catch  {
            print("error retrieving profile notes")
        }
        
        return ""
    }
    
    
    func addNewNotes(name: String , notes: String) -> Bool{
 
        
        
//        if getProfileNotes(name: name) != ""{
//
//            do{
//            let request = ExplorerNotes.fetchRequest() as NSFetchRequest<ExplorerNotes>
//            let predicate  = NSPredicate(format: "name == '\(name)'")
//            request.predicate = predicate
//            let result = try context.fetch(request)
//            if result.count != 0 {
//                var dataNotes = notesExplorer(name: result[0].name ?? "", notes: result[0].notes ?? "")
//
//                dataNotes.notes = notes
//
//
//                do {
//                    try self.context.save()
//                } catch  {
//                    print()
//                }
//
//
//            }
//
//            } catch  {
//                print("error retrieving achievement")
//            }
//
            
            
//        }else{
            
            let newNotes = ExplorerNotes(context: self.context)
            newNotes.name = name
            newNotes.notes = notes

            //save the data
            do{
                try self.context.save()
                return true
            }catch{
                print(error)
                return false
            }
//        }
        
        

        
       
        

    }
    
    
    
    public func checkAchievementCompletion(tipe: String){
        
        statusAchievement = false
        
        
        do{
            self.master =  try context.fetch(MasterExplorer.fetchRequest())
            self.instagram = try context.fetch(SocialStalker.fetchRequest())
            self.linkedin = try context.fetch(LinkedinHunter.fetchRequest())
            
        }catch{
         print("error retrieving achievement data")
        }
        
        
        // get all value
        if let linkedinData = linkedin {
            linkedinCount = linkedinData.count
        }
        
        if let instagramData = instagram {
            instagramCount = instagramData.count
        }
        
        if let newComerData = master {
            newComerCount = newComerData.count
        }
        
        if let masterData = master {
            masterCount = masterData.count 
        }
        
        
        
        
        if tipe == "linkedin" {
            
            if linkedinCount == 50 {
                if readFromUserDefault(tipe: "linkedin") == false {
                    statusAchievement = true;
                }
            }

            
        }else if tipe == "instagram"{
            
            if instagramCount == 50 {
                if readFromUserDefault(tipe: "instagram") == false {
                    statusAchievement = true;
                }
            }
      
         
        }else if tipe == "newcomer"{
            
            if newComerCount == 1 {
                if readFromUserDefault(tipe: "newcomer") == false {
                    statusAchievement = true;
                }
            }
           
        }else if tipe == "master"{
            
            if masterCount == 111 {
                if readFromUserDefault(tipe: "master") == false {
                    statusAchievement = true;
                }
            }
            
        }else if tipe == "allknowing"{
            
            
            if readFromUserDefault(tipe: "linkedin") && readFromUserDefault(tipe: "instagram") && readFromUserDefault(tipe: "master")
            {
                statusAchievement = true
                let preferences = UserDefaults.standard
                preferences.removeObject(forKey: "linkedin")
                preferences.removeObject(forKey: "instagram")
                preferences.removeObject(forKey: "master")
                preferences.synchronize()
               
            }
            

        }
        
        
        
        if statusAchievement == true {
            
            if tipe == "linkedin" {
                achTitle = "Connection Hunter"
                achDesc = "Access 50 explorer linkedin"
                achFoto = "linkedin"
                saveToUserDefault(tipe: tipe)
                
            }else if tipe == "instagram"{
                achTitle = "Social Media Stalker"
                achDesc = "Access 50 explorer instagram"
                achFoto = "instagram"
                saveToUserDefault(tipe: tipe)
                
            }else if tipe == "newcomer"{
                achTitle = "Newcomer"
                achDesc = "See your first explorer detail"
                achFoto = "baby"
                saveToUserDefault(tipe: tipe)
                
            }else if tipe == "allknowing"{
                
                    achTitle = "All Knowing"
                    achDesc = "Finish all achievements"
                    achFoto = "king"
                saveToUserDefault(tipe: tipe)
                
            }else if tipe == "master"{
                achTitle = "Master of Explorer"
                achDesc = "See all explorer detail"
                achFoto = "search"
                saveToUserDefault(tipe: tipe)
            }
            
            
            if let PopViewController = self.storyboard?.instantiateViewController(identifier: "AchievementPopUp") as? PopUpViewController{
                PopViewController.achievement = Achievement(title: achTitle, progress: "1", description: achDesc, photo: achFoto)
                self.navigationController?.present(PopViewController, animated: true)
        
            }
        }
        
   
        
        
    }
    
    
    func saveToUserDefault(tipe : String){
        let preferences = UserDefaults.standard
        preferences.setValue(tipe, forKey: tipe)
        preferences.synchronize()
    }
    
    func readFromUserDefault(tipe: String) -> Bool{
        let preferences = UserDefaults.standard
        if preferences.object(forKey: tipe) == nil {
            return false
        } else {
           return true
        }
    }
    
    func showAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

               // add an action (button)
               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

               // show the alert
               self.present(alert, animated: true, completion: nil)
    }
    
    
    struct notesExplorer{
        var name: String
        var notes: String
    }
    

}


protocol DetailExplorerDelegate:AnyObject {
    func getExplorerData()->Explorer?
}
