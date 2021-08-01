//
//  DetailView.swift
//  Contacts
//
//  Created by administrator on 22/07/2021.
//

import SwiftUI


struct LazyView<Content: View>: View {
	let build: () -> Content
	init(_ build: @autoclosure @escaping () -> Content) {
		self.build = build
	}
	var body: Content {
		build()
	}
}

struct DetailView: View {
	let person: Person
	let friendList: FetchedResults<Person>
    var body: some View {
		VStack(spacing: 10){
			VStack{
				Image(systemName: "person.circle.fill")
					.resizable()
					.scaledToFit()
					.frame(width: 60, height: 60, alignment: .center)
					.padding()
			}
			VStack(alignment: .leading){
				Text("Company: \(person.realCompany)")
				Text("Email: \t \(person.realEmail)")
				Text("Address: \t \(person.realAddress)")
				
			}
			.padding(.horizontal, 5)
			
			
			Section(header: Text("About")){
				ScrollView(.vertical){
					Text("\(person.realAbout)")
				}
				.padding(.horizontal)
				.frame(height: 200)
			}
			
			Section(header: Text("Peer List")){
				List{
				ForEach(person.realFriends, id: \.self.id){ peer in
					let details = self.peerDetails(list: friendList, id: peer.realID)
					HStack{
						Image(systemName: "person")
						Text("\(details?.name ?? "Unknown")")
						NavigationLink("", destination: DetailView(person: details!, friendList: friendList))
					}
					
				}
				}
				.frame(height: 220)
			}
			
			
		}
		
		.navigationBarTitle("\(person.realName)")
    }
	
	func peerDetails(list: FetchedResults<Person>, id: UUID) -> Person? {
		guard let index = list.firstIndex(where: {$0.id == id}) else{
			return nil
		}
		return list[index]
		
	}
	
}


