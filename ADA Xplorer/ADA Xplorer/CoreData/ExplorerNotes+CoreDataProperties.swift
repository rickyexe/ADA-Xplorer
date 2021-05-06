//
//  ExplorerNotes+CoreDataProperties.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 06/05/21.
//
//

import Foundation
import CoreData


extension ExplorerNotes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExplorerNotes> {
        return NSFetchRequest<ExplorerNotes>(entityName: "ExplorerNotes")
    }

    @NSManaged public var name: String?
    @NSManaged public var notes: String?

}

extension ExplorerNotes : Identifiable {

}
