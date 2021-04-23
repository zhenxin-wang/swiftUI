//
//  EditingPage.swift
//  ToDoList
//
//  Created by DMS on 2021/4/20.
//

import SwiftUI

struct EditingPage: View {
    @EnvironmentObject var UserData: ToDo
    
    @State var title: String = ""
    @State var toDate: Date = Date()
    @State var isFavorite: Bool = false
    var id:Int? = nil
    
    @Environment(\.presentationMode) var presentation
    var body: some View {
        NavigationView{
            Form{
                Section(header:Text("事件")) {
                    TextField("事项内容", text: self.$title)
                    DatePicker(selection: self.$toDate){
                        Text("截止时间")
                    }
                }
                Section{
                    Toggle(isOn: self.$isFavorite) {
                        Text("收藏")
                    }
                }
                Section{
                    Button(action: {
                        if id == nil{
                            self.UserData.add(data: SingleToDu( title: self.title, toDate: self.toDate,isFavorite:self.isFavorite))
                        }else{
                            self.UserData.edit(id: id!, data: SingleToDu(title: self.title, toDate: self.toDate,isFavorite:self.isFavorite))
                        }
                        
                        self.presentation.wrappedValue.dismiss()
                    }){
                        if id == nil{
                            Text("新增")
                        }else{
                            Text("修改")
                        }
                        
                    }
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }){
                        Text("取消")
                    }
                    
                }
            }
            .navigationBarTitle(Text("添加"))
        }
    }
}

struct EditingPage_Previews: PreviewProvider {
    static var previews: some View {
        EditingPage()
    }
}
