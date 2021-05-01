//
//  ExplorerManager.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 30/04/21.
//

import Foundation

public class ExplorerManager{
    
    var explorers: [Explorer]
    
    init(){
        
        explorers = []
        
        if let localData = self.readLocalFile(forName: "explorers") {
            self.parse(jsonData: localData)
        }
    }

    
    
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
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([ExplorerData].self,
                                                       from: jsonData)
            
            for data in decodedData{
                explorers.append(Explorer(Name: data.Name, Shift: data.Shift, Expertise: data.Expertise, Photo: data.Photo, Team: data.Team))
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
