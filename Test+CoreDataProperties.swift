//
//  Test+CoreDataProperties.swift
//  Contacts
//
//  Created by administrator on 22/07/2021.
//
//

import Foundation
import CoreData


extension Test {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Test> {
        return NSFetchRequest<Test>(entityName: "Test")
    }

    @NSManaged public var id: UUID?

}

extension Test : Identifiable {

}
