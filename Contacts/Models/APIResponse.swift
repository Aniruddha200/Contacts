//
//  APIResponse.swift
//  Contacts
//
//  Created by administrator on 17/07/2021.
//

import Foundation
struct APIFormat: Codable, Identifiable{
	
	var id: UUID
	var isActive: Bool
	var name: String
	var age: Int64
	var company: String
	var email: String
	var address: String
	var about: String
	var registered: String
	var tags: [String]
	var friends: [Friend]
	
	var formattedReg: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd MM yy"
		let reg = formatter.date(from: registered)
		formatter.dateStyle = .medium
		return formatter.string(from: reg ?? Date())
	}
	
	struct Friend: Codable, Identifiable{
		var id: UUID
		var name: String
		
		
	}
	
}


