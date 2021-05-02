//
//  MasterExplorer+CoreDataProperties.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 02/05/21.
//
//

import Foundation
import CoreData


extension MasterExplorer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MasterExplorer> {
        return NSFetchRequest<MasterExplorer>(entityName: "MasterExplorer")
    }

    @NSManaged public var name: String?

}

extension MasterExplorer : Identifiable {

}
