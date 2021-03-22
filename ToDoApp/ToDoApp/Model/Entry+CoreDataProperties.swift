//
//  Entry+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Nitin Patil on 19/03/21.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var type: String?

}

extension Entry : Identifiable {

}
