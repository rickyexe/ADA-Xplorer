//
//  ExplorerViewController.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 30/04/21.
//

import UIKit

class ExplorerViewController: UIViewController {
  
    
    @IBOutlet weak var explorerSegmentedControl: UISegmentedControl!
    @IBOutlet weak var explorerTable: UITableView!
    var explorers:[Explorer]!
    var indexCellSelected:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Explorers"
        explorerTable.dataSource = self
        explorerTable.delegate = self
        explorers = []
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
            if explorers != nil {
                explorers.removeAll()
            }
         
            
            for data in decodedData{
                if type == "IT" {
                    if data.Expertise == "Tech / IT / IS"{
                        explorers.append(Explorer(Name: data.Name, Shift: data.Shift, Expertise: data.Expertise, Photo: data.Photo, Team: data.Team))
                    }
                }else if type == "DESIGN"{
                    if data.Expertise == "Design"{
                        explorers.append(Explorer(Name: data.Name, Shift: data.Shift, Expertise: data.Expertise, Photo: data.Photo, Team: data.Team))
                    }
                }else{
                    if data.Expertise == "Domain Expert (Keahlian Khusus)"{
                        explorers.append(Explorer(Name: data.Name, Shift: data.Shift, Expertise: data.Expertise, Photo: data.Photo, Team: data.Team))
                    }
                }
            }
            
        } catch {
            print(error)
        }
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
        return explorers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "testCell") as? ExplorerTableViewCell{
            cell.explorerName?.text = explorers[indexPath.row].Name
            cell.explorerShift?.text = explorers[indexPath.row].Shift
            cell.explorerExpertise?.text = explorers[indexPath.row].Expertise
            cell.explorerPicture?.image = UIImage(named: explorers[indexPath.row].Photo)
            return cell
      
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
            return explorers[indexExplorer.row]
        }else{
            return nil;
        }
    }
}
