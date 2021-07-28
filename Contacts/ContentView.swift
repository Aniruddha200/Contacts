//
//  ContentView.swift
//  Contacts
//
//  Created by administrator on 17/07/2021.
//

import SwiftUI
import CoreData




struct ContentView: View {
	
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(entity: Person.entity(), sortDescriptors: []) var persons: FetchedResults<Person>
	//	@ObservedObject var model = APIResult([APIFormat]())
	
	@State private var friendList = [APIFormat]()
	
	var body: some View {
		NavigationView{
			List{
				ForEach(persons, id: \.self.id){person in
					HStack{
						Image(systemName: "person.circle")
						Text("\(person.realName)")
						NavigationLink("", destination: DetailView(person:person, friendList: persons))
					}
				}
				.onDelete(perform: delete)
			}
			
			.navigationBarTitle("Friends", displayMode: .inline)
			.navigationBarItems(leading: EditButton(), trailing:
									Button(action: fetchData)
										{Image(systemName: "tray.and.arrow.down.fill")})
		}
	}
	
	func delete(of index: IndexSet) {
		for i in index{
			moc.delete(persons[i])
		}
	}
	
	func fetchData() {
		
		//		model.fetchData()
		
		let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
		let request = URLRequest(url: url)
		URLSession.shared.dataTask(with: request){(data, _, error) in
			
			if let data = data{
				if let decodedData = try? JSONDecoder().decode([APIFormat].self, from: data){
					DispatchQueue.main.async {
						self.friendList = decodedData
					}
				}
				else{
					print("Decoding Failed")
				}
			}
			else{
				print("No data found")
			}
			
			
		}.resume()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
			
			for item in friendList {
				let Person = Person(context: moc)
				Person.id = item.id
				Person.isActive = item.isActive
				Person.name = item.name
				Person.age = item.age
				Person.company = item.company
				Person.email = item.email
				Person.address = item.address
				Person.about = item.about
				Person.registered = item.formattedReg
				//				Person.tags = item.tags
				for j in item.friends{
					let Friend = Friends(context: moc)
					Friend.id = j.id
					Friend.name = j.name
					Friend.addToPeer(Person)
					
					Person.addToFriends(Friend)
					
					if moc.hasChanges{
						do{
							try moc.save()
						}
						catch{
							print("Error is: \(error.localizedDescription)")
							fatalError("Oops! Could save the data!")
						}
					}
					
				}
				
				if moc.hasChanges{
					do{
						try moc.save()
					}
					catch{
						print("Error is: \(error.localizedDescription)")
						fatalError("Oops! Could save the data!")
					}
				}
			}
		}
	}
}



struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
