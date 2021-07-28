//
//  DetailView.swift
//  Contacts
//
//  Created by administrator on 22/07/2021.
//

import SwiftUI

struct DetailView: View {
	let person: Person
	let friendList: FetchedResults<Person>
    var body: some View {
		VStack(spacing: 10){
				Image(systemName: "person")
					.resizable()
					.scaledToFit()
					.frame(width: 60, height: 60, alignment: .center)
					.padding()
			Section(header: Text("Details").font(.title)){
				Text("From: \(person.realCompany)")
					.fontWeight(.bold)
				Text("Email: \t \(person.realEmail)")
					.fontWeight(.bold)
				Text("Address: \t \(person.realAddress)")
					.fontWeight(.bold)
					.padding(.horizontal)
			}
			
			Section(header: Text("About").font(.title)){
				ScrollView(.vertical){
					Text("\(person.realAbout)")
						.padding()
				}
				.frame(height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
			}
			
			Section(header: Text("Peer List").font(.title)){
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


