//
//  LinkedinHunter+CoreDataProperties.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 02/05/21.
//
//

import Foundation
import CoreData


extension LinkedinHunter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LinkedinHunter> {
        return NSFetchRequest<LinkedinHunter>(entityName: "LinkedinHunter")
    }

    @NSManaged public var name: String?

}

extension LinkedinHunter : Identifiable {

}
