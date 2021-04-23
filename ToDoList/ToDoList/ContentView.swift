//
//  ContentView.swift
//  ToDoList
//
//  Created by DMS on 2021/4/20.
//

import SwiftUI

var formatter = DateFormatter()


func initUserData() -> [SingleToDu]{
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    var output: [SingleToDu] = []
    if let dataStored = UserDefaults.standard.object(forKey: "ToDoList") as? Data {
        let  data = try! decoder.decode([SingleToDu].self, from: dataStored)
        for item in data {
            if !item.deleted {
                output.append(SingleToDu(id: output.count, title: item.title, toDate: item.toDate, isChecked: item.isChecked,isFavorite: item.isFavorite))
            }
        }
    }
    
    return output
}

struct ContentView: View {
    @ObservedObject var UserData:ToDo = ToDo(data: initUserData())
    
    @State var showEditingPage: Bool = false
    @State var editingMode = false
    @State var showLikeMode = false
    @State var selection: [Int] = []
    var body: some View {
        ZStack{
            NavigationView{
                ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                        ForEach(self.UserData.ToDoList) { item in
                            if !item.deleted {
                                if !self.showLikeMode || item.isFavorite {
                                    SingleCardView(index: item.id, editingMode:self.$editingMode, selection:self.$selection, showLikeMode: self.$showLikeMode)
                                        .environmentObject(self.UserData)
                                        .padding(.top)
                                        .padding(.horizontal)
                                        .animation(.spring())
                                        .transition(.slide)
                                }
                                
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("提醒事项"))
                .navigationBarItems(trailing:
                                        HStack{
                                            ShowLikeButton(showLikeMode:self.$showLikeMode)
                                            if self.editingMode{
                                                DeleteButton(selection: self.$selection)
                                                    .environmentObject(self.UserData)
                                            }
                                            EditingButton(editingMode: self.$editingMode)
                                            
                                        }
                )
            }
            
            HStack{
                Spacer()
                VStack{
                    Spacer()
                    Button(action:{
                        self.showEditingPage = true
                    }){
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:80)
                            .foregroundColor(.blue)
                            .padding(.trailing)
                    }
                    .sheet(isPresented: self.$showEditingPage, content: {
                        EditingPage()
                            .environmentObject(self.UserData)
                            
                    })
                    
                        
                }
                
            }
            
        }
        
    }
}

struct EditingButton: View {
    @Binding var editingMode: Bool
    var body: some View {
        Button(action:{
            self.editingMode.toggle()
        }){
            Image(systemName: "gear")
                .imageScale(.large)
        }
        
    }
    
}
struct ShowLikeButton: View {
    @Binding var showLikeMode: Bool
    var body: some View {
        Button(action:{
            self.showLikeMode.toggle()
        }){
            Image(systemName: self.showLikeMode ? "star.fill" : "star")
                .imageScale(.large)
                .foregroundColor(.orange)
        }
        
    }
    
}
struct DeleteButton: View {
//    @Binding var editingMode: Bool
    @EnvironmentObject var UserData: ToDo
    @Binding var selection: [Int]
    var body: some View {
        Button(action:{
//            self.editingMode.toggle()
            for index in self.selection{
                self.UserData.delete(id: index)
            }
            
        }){
            Image(systemName: "trash")
                .imageScale(.large)
        }
        
        
    }
    
}
struct SingleCardView: View {
    @EnvironmentObject var UserData: ToDo
    var index: Int
    
    @State var showEditingPage: Bool = false
    
    @Binding var editingMode: Bool
    @Binding var selection: [Int]
    @Binding var showLikeMode: Bool
    var body: some View {

        HStack {
            Rectangle()
                .frame(width:10)
                .foregroundColor(Color("Color" + String(self.index % 5)))
            if editingMode{
                Button(action:{
                    self.UserData.ToDoList[index].deleted = true
                }){
                    Image(systemName: "trash")
                        .imageScale(.large)
                        .padding(.leading)
                }
            }
            
            Button(action:{
                if !self.editingMode{
                    self.showEditingPage = true
                }
                
            }){
                Group{
                    VStack(alignment: .leading,spacing:10) {
                        Text(self.UserData.ToDoList[index].title)
                            .font(.headline)
                            .foregroundColor(.black)
                            .fontWeight(.heavy)
                        Text(formatter.string(from: self.UserData.ToDoList[index].toDate))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading)
                    Spacer()
                }
            }
            .sheet(isPresented: self.$showEditingPage, content: {
                EditingPage(title:self.UserData.ToDoList[index].title, toDate: self.UserData.ToDoList[index].toDate, isFavorite:self.UserData.ToDoList[index].isFavorite, id: index)
                    .environmentObject(self.UserData)
            })
            
            if self.UserData.ToDoList[index].isFavorite{
                Image(systemName: "star.fill")
                    .imageScale(.large)
                    .foregroundColor(.orange)
            }
            
            
            if !self.editingMode{
                Image(systemName:self.UserData.ToDoList[index].isChecked ? "checkmark.square.fill" : "square")
                    .imageScale(.large)
                    .padding(.trailing)
                    .onTapGesture {
                        self.UserData.check(id: index)
                    }
            }else{
                Image(systemName:self.selection.firstIndex(where: {$0 == self.index}) == nil ? "circle" : "checkmark.circle.fill")
                    .imageScale(.large)
                    .padding(.trailing)
                    .onTapGesture {
                        if self.selection.firstIndex(where: {
                            $0 == self.index
                        }) == nil{
                            self.selection.append(self.index)
                        }else{
                            self.selection.remove(at: self.selection.firstIndex(where: {
                                $0 == self.index
                            })!)
                        }
                    }
            }
            
        }
        .frame(height:80)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10,x:0,y:10 )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(UserData: ToDo(data: [SingleToDu(title: "Vue", toDate: Date(),isFavorite: false ),SingleToDu(title: "swift UI", toDate: Date(),isFavorite: false )]))
    }
}
