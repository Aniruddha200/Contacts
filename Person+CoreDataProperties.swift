//
//  Person+CoreDataProperties.swift
//  Contacts
//
//  Created by administrator on 28/07/2021.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int64
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: String?
    @NSManaged public var friends: NSSet?
	
	public var realId: UUID {return id ?? UUID()}
	public var realName: String {return name ?? "N/A"}
	public var realCompany: String {return company ?? "N/A"}
	public var realEmail: String {return email ?? "N/A"}
	public var realAddress: String {return address ?? "N/A"}
	public var realAbout: String {return about ?? "N/A"}
	public var realRegistered: String {return registered ?? "N/A"}
//	public var realTags: [String] {return tags ?? [String]()}
	public var realFriends: [Friends] {
		let set = friends as! Set<Friends>
		return set.sorted{
			$0.id < $1.id
		}
	}

}

// MARK: Generated accessors for friends
extension Person {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friends)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friends)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension Person : Identifiable {

}
