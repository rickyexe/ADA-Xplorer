//
//  ExplorerViewController.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 30/04/21.
//

import UIKit
import CoreData

class ExplorerViewController: UIViewController {
  
    
    @IBOutlet weak var searchExplorerBar: UISearchBar!
    @IBOutlet weak var explorerSegmentedControl: UISegmentedControl!
    @IBOutlet weak var explorerTable: UITableView!
    var explorers:[Explorer]!
    var filtered: [Explorer]!
    var indexCellSelected:IndexPath?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Explorers"
        explorerTable.dataSource = self
        explorerTable.delegate = self
        searchExplorerBar.delegate = self
        explorers = []
        filtered = []
        if let localData = self.readLocalFile(forName: "explorers") {
            self.parse(jsonData: localData, type: "IT")
        }
        
        
    }
    
    
    
    
    
    
    
    //segmented control handle
    @IBAction func changeType(_ sender: Any) {
        
        switch explorerSegmentedControl.selectedSegmentIndex
           {
           case 0:
            if let localData = self.readLocalFile(forName: "explorers") {
                self.parse(jsonData: localData, type: "IT")
            }
            explorerTable.reloadData()
           case 1:
            if let localData = self.readLocalFile(forName: "explorers") {
                self.parse(jsonData: localData, type: "DESIGN")
            }
            explorerTable.reloadData()
            case 2:
                if let localData = self.readLocalFile(forName: "explorers") {
                    self.parse(jsonData: localData, type: "DOMAIN")
                }
            explorerTable.reloadData()
           default:
               break
           }
    }
    
    
    
    
    
    
    //read json data
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    
    //parse json data and inject to explorers array
    private func parse(jsonData: Data, type : String) {
        do {
            let decodedData = try JSONDecoder().decode([ExplorerData].self,
                                                       from: jsonData)
            
            
            if searchActive == true {
                if filtered != nil{
                    filtered.removeAll()
                }
            }else{
                if explorers != nil {
                    explorers.removeAll()
                }
            }
         
            
          
         
            
            for data in decodedData{
                if type == "IT" {
                    if data.Expertise == "Tech / IT / IS"{
                        if searchActive == true {
                            filtered.append(Explorer(Name: data.Name, Shift: data.Shift, Expertise: data.Expertise, Photo: data.Photo, Team: data.Team))
                        }else{
                            explorers.append(Explorer(Name: data.Name, Shift: data.Shift, Expertise: data.Expertise, Photo: data.Photo, Team: data.Team))
                        }
                     
                    }
                }else if type == "DESIGN"{
                    if data.Expertise == "Design"{
                        if searchActive == true {
                            filtered.append(Explorer(Name: data.Name, Shift: data.Shift, Expertise: data.Expertise, Photo: data.Photo, Team: data.Team))
                        }else{
                            explorers.append(Explorer(Name: data.Name, Shift: data.Shift, Expertise: data.Expertise, Photo: data.Photo, Team: data.Team))
                        }
                    }
                }else{
                    if data.Expertise == "Domain Expert (Keahlian Khusus)"{
                        if searchActive == true {
                            filtered.append(Explorer(Name: data.Name, Shift: data.Shift, Expertise: data.Expertise, Photo: data.Photo, Team: data.Team))
                        }else{
                            explorers.append(Explorer(Name: data.Name, Shift: data.Shift, Expertise: data.Expertise, Photo: data.Photo, Team: data.Team))
                        }
                    }
                }
            }
            
        } catch {
            print(error)
        }
    }
    
    
    func insertMaster(name : String ){
        //insert to master model
        let master = getMasterAchievementStatus(name: name)
        if master == true {
            let newMaster = MasterExplorer(context: self.context)
            newMaster.name = name
        }

        //save the data
        do{
            try self.context.save()
        }catch{
            print(error)
        }

        
    }
    
    func getMasterAchievementStatus(name : String) -> Bool{
        
        let request = MasterExplorer.fetchRequest() as NSFetchRequest<MasterExplorer>

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
    
    
    
    struct ExplorerData: Codable {
        let Name: String
        let Photo: String
        let Expertise: String
        let Team : String
        let Shift: String
    }
    
    

}


extension ExplorerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive == true {
            return filtered.count
        }else{
            return explorers.count
        }
  
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "testCell") as? ExplorerTableViewCell{
            
            if searchActive == true {
                cell.explorerName?.text = filtered[indexPath.row].Name
                cell.explorerShift?.text = filtered[indexPath.row].Shift
                cell.explorerExpertise?.text = filtered[indexPath.row].Expertise
                cell.explorerPicture?.image = UIImage(named: filtered[indexPath.row].Photo)
                return cell
            }else{
                cell.explorerName?.text = explorers[indexPath.row].Name
                cell.explorerShift?.text = explorers[indexPath.row].Shift
                cell.explorerExpertise?.text = explorers[indexPath.row].Expertise
                cell.explorerPicture?.image = UIImage(named: explorers[indexPath.row].Photo)
                return cell
            }
      
        }
        return UITableViewCell()
    }
}

extension ExplorerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailExplorerViewController = self.storyboard?.instantiateViewController(identifier: "DetailExplorer") as? ExplorerDetailViewController{
            indexCellSelected = indexPath
            detailExplorerViewController.detailExplorerDelegate = self
            self.navigationController?.pushViewController(detailExplorerViewController, animated: true)
        }
    }
    
}

extension ExplorerViewController: DetailExplorerDelegate{
    func getExplorerData() -> Explorer? {
        if let indexExplorer = indexCellSelected as IndexPath?{
            
            if searchActive == true {
                insertMaster(name: filtered[indexExplorer.row].Name)
                return filtered[indexExplorer.row]
            }else{
                insertMaster(name: explorers[indexExplorer.row].Name)
                return explorers[indexExplorer.row]
            }
            
           
        }else{
            return nil;
        }
    }
}

extension ExplorerViewController: UISearchBarDelegate {
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchExplorerBar.endEditing(true)
        self.explorerTable.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchExplorerBar.endEditing(true)
        self.explorerTable.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchExplorerBar.endEditing(true)
//        self.explorerTable.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        //ideas is to filter the current explorer data
        
//        if searchText == "" {
//            filtered = explorers
//        }else{
        
        if searchActive == true {
            filtered = filtered.filter({$0.Name.lowercased().contains(searchText.lowercased())})
        }else{
            filtered = explorers.filter({$0.Name.lowercased().contains(searchText.lowercased())})
        }
            
//        }
        
        if filtered.count == 0 {
            searchActive = false
        }else{
            searchActive = true
        }
        
        

//        filtered = explorers.filter({ (text) -> Bool in
//            let tmp: NSString = text
//            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
//            return range.location != NSNotFound
//        })
        
//        if(filtered.count == 0){
//            searchActive = false;
//        } else {
//            searchActive = true;
//        }
//
        self.explorerTable.reloadData()
    }
}
