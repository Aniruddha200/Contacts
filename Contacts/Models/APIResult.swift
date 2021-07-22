//
//  APIResult.swift
//  Contacts
//
//  Created by administrator on 17/07/2021.
//

import Foundation


class APIResult{
	
	var result = [APIFormat]()
	
	
	func fetchResult(_ url: String) {
		let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
		let request = URLRequest(url: url)
		URLSession.shared.dataTask(with: request){(data, _, error) in
			
			if let data = data{
				if let decodedData = try? JSONDecoder().decode([APIFormat].self, from: data){
					self.result = decodedData
				}
				else{
					print("Decoding Failed")
				}
			}
			else{
				print("No data found")
			}

			
		}
	}
	
}


