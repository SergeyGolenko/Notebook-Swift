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
    
    func month() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        if let dateToBeFormatted = date {
           let month = formatter.string(from: dateToBeFormatted)
            return month.uppercased()
        }
        return ""
    }
    
    func day() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        if let dateToBeFormatted = date {
           let day = formatter.string(from: dateToBeFormatted)
            return day.uppercased()
        }
        return ""
    }
        
    }


