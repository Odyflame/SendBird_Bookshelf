//
//  Note+CoreDataProperties.swift
//  SendBird
//
//  Created by apple on 2021/03/25.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var isbn13: String?
    @NSManaged public var note: String?

}

extension Note {
    
}
