//
//  DetailView.swift
//  Contacts
//
//  Created by administrator on 22/07/2021.
//

import SwiftUI

struct DetailView: View {
	let person: APIFormat
	let friendList: [APIFormat]
    var body: some View {
		VStack(spacing: 30){
				Image(systemName: "person")
					.resizable()
					.scaledToFit()
					.frame(width: 100, height: 100, alignment: .center)
					.padding()
				Text("Email: \t \(person.email)")
					.fontWeight(.bold)
				Text("Address: \t \(person.address)")
					.fontWeight(.bold)
				ScrollView(.vertical){
					Text("\(person.about)")
						.padding()
				}
			Section(header: Text("Peer List")){
				List{
				ForEach(person.friends, id: \.self.id){ peer in
					let details = self.peerDetails(list: friendList, id: peer.id)
					HStack{
						Image(systemName: "person")
						Text("\(details?.name ?? "Unknown")")
						NavigationLink("", destination: DetailView(person: details!, friendList: friendList))
					}
					
				}
				}
			}
			
		}
				
		
		.navigationBarTitle("\(person.name)")
    }
	
	func peerDetails(list: [APIFormat], id: String) -> APIFormat? {
		guard let index = list.firstIndex(where: {$0.id == id}) else{
			return nil
		}
		return list[index]
		
	}
	
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
		Text("")
//        DetailView()
    }
}
