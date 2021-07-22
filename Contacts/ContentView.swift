//
//  ContentView.swift
//  Contacts
//
//  Created by administrator on 17/07/2021.
//

import SwiftUI
import CoreData


/*
https://www.hackingwithswift.com/samples/friendface.json


*/



struct ContentView: View {
	
	@State private var friendList = [APIFormat]()
	var body: some View {
		NavigationView{
			List{
				ForEach(friendList, id: \.self.id){friend in
					HStack{
						Image(systemName: "person.circle")
						Text("\(friend.name)")
						NavigationLink("", destination: DetailView(person:friend, friendList: friendList))
					}
				}
			}
			
			.navigationBarTitle("Friends", displayMode: .inline)
			.navigationBarItems(leading: EditButton(), trailing:
									Button(action: {fetchData()})
										{Image(systemName: "tray.and.arrow.down.fill")})
		}
	}
	
	func fetchData() {
		let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
		let request = URLRequest(url: url)
		URLSession.shared.dataTask(with: request){(data, _, error) in
			
			if let data = data{
				if let decodedData = try? JSONDecoder().decode([APIFormat].self, from: data){
					self.friendList = decodedData
				}
				else{
					print("Decoding Failed")
				}
			}
			else{
				print("No data found")
			}

			
		}.resume()
		
	}
}



struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
