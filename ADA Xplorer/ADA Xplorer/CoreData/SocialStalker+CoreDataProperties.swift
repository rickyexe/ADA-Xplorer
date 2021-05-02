//
//  SocialStalker+CoreDataProperties.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 02/05/21.
//
//

import Foundation
import CoreData


extension SocialStalker {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SocialStalker> {
        return NSFetchRequest<SocialStalker>(entityName: "SocialStalker")
    }

    @NSManaged public var name: String?

}

extension SocialStalker : Identifiable {

}
