//
//  APIResponse.swift
//  Contacts
//
//  Created by administrator on 17/07/2021.
//

import Foundation


struct APIFormat: Codable, Identifiable{
	
	var id: String
	var isActive: Bool
	var name: String
	var age: Int
	var company: String
	var email: String
	var address: String
	var about: String
	var registered: String
	var tags: [String]
	var friends: [Friend]
	
	struct Friend: Codable, Identifiable{
		var id: String
		var name: String
	}
	
}


