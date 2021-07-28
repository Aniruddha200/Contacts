//
//  Friends+CoreDataProperties.swift
//  Contacts
//
//  Created by administrator on 28/07/2021.
//
//

import Foundation
import CoreData


extension Friends {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friends> {
        return NSFetchRequest<Friends>(entityName: "Friends")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var peer: NSSet?
	
	public var realID: UUID {return id ?? UUID()}
	public var realName: String {return name ?? "N/A"}
	public var realPeer: [Person] {
		let set = peer as? Set<Person> ?? []
		return set.sorted{
			$0.id < $1.id
		}
	}

}

// MARK: Generated accessors for peer
extension Friends {

    @objc(addPeerObject:)
    @NSManaged public func addToPeer(_ value: Person)

    @objc(removePeerObject:)
    @NSManaged public func removeFromPeer(_ value: Person)

    @objc(addPeer:)
    @NSManaged public func addToPeer(_ values: NSSet)

    @objc(removePeer:)
    @NSManaged public func removeFromPeer(_ values: NSSet)

}

extension Friends : Identifiable {

}
