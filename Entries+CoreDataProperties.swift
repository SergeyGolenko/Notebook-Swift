//
//  Entries+CoreDataProperties.swift
//  NotebookSwift
//
//  Created by Сергей Голенко on 16.12.2020.
//
//

import Foundation
import CoreData


extension Entries {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entries> {
        return NSFetchRequest<Entries>(entityName: "Entries")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: Date?

}

extension Entries : Identifiable {

}
