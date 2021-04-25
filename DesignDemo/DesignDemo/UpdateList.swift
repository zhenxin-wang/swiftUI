//
//  UpdateList.swift
//  DesignDemo
//
//  Created by DMS on 2021/3/11.
//

import SwiftUI

struct UpdateList: View {
    @State var showModelView = false
    var updates = updateData
    @ObservedObject var store = UpdateStore(updates: updateData)
    
    func addUpdate(){
        store.updates.append(Update(image: "Card6", title: "new title", text: "new text", date: "JUN 1"))
    }
    func move(form source:IndexSet,to destination: Int){
        store.updates.swapAt(source.first!, destination)
    }
    var body: some View {
        NavigationView {
            
            List{
                ForEach(store.updates) { item in
                    NavigationLink(destination: UpdateDtail(title:item.title, text:item.text, image:item.image, date:item.date)) {
                        HStack(spacing: 14.0) {
                            Image(item.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:80,height:80)
                                .background(Color("background2"))
                                .cornerRadius(20)
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                
                                Text(item.text)
                                    .lineLimit(2)
                                    .lineSpacing(4)
                                    .font(.subheadline)
                                    .frame(height:50)
                                
                                Text(item.date)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                    
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    self.store.updates.remove(at: indexSet.first!)
                }
                .onMove(perform:move)
                
            }
            .navigationBarTitle(Text("Updates"))
            .navigationBarItems(
                leading:Button(action:addUpdate){
                    Text("add Update")
                },
                trailing:EditButton()

            )
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View { 
        UpdateList()
    }
}

struct Update : Identifiable{
    var id = UUID()
    var image : String
    var title : String
    var text : String
    var date : String
}

let updateData = [
    Update(image: "Card1", title: "SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.", date: "JAN 1"),
    Update(image: "Card2", title: "Webflow", text: "Design and animate a high converting landing page with advanced interactions, payments and CMS", date: "OCT 17"),
    Update(image: "Card3", title: "ProtoPie", text: "Quickly prototype advanced animations and interactions for mobile and Web.", date: "AUG 27"),
    Update(image: "Card4", title: "SwiftUI", text: "Learn how to code custom UIs, animations, gestures and components in Xcode 11", date: "JUNE 26"),
    Update(image: "Card5", title: "Framer Playground", text: "Create powerful animations and interactions with the Framer X code editor", date: "JUN 11"),
    Update(image: "Card1", title: "SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.", date: "JAN 1"),
    Update(image: "Card2", title: "Webflow", text: "Design and animate a high converting landing page with advanced interactions, payments and CMS", date: "OCT 17"),
    Update(image: "Card3", title: "ProtoPie", text: "Quickly prototype advanced animations and interactions for mobile and Web.", date: "AUG 27"),
    Update(image: "Card4", title: "SwiftUI", text: "Learn how to code custom UIs, animations, gestures and components in Xcode 11", date: "JUNE 26"),
    Update(image: "Card5", title: "Framer Playground", text: "Create powerful animations and interactions with the Framer X code editor", date: "JUN 11"),
    Update(image: "Card1", title: "SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.", date: "JAN 1"),
    Update(image: "Card2", title: "Webflow", text: "Design and animate a high converting landing page with advanced interactions, payments and CMS", date: "OCT 17"),
    Update(image: "Card3", title: "ProtoPie", text: "Quickly prototyp e advanced animations and interactions for mobile and Web.", date: "AUG 27"),
    Update(image: "Card4", title: "SwiftUI", text: "Learn how to code custom UIs, animations, gestures and components in Xcode 11", date: "JUNE 26"),
    Update(image: "Card5", title: "Framer Playground", text: "Create powerful animations and interactions with the Framer X code editor", date: "JUN 11")
]
