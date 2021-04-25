//
//  Settings.swift
//  DesignDemo
//
//  Created by DMS on 2021/4/6.
//

import SwiftUI

struct Settings: View {
    @State var receive = false
    @State var number = 1
    @State var selection = 1
    @State var date = Date()
    @State var email = ""
    @State var sumbit = false
    var body: some View {
        NavigationView{
            Form{
                Toggle(isOn: $receive, label: {
                    Text("Receive notifications")
                })
                Stepper(value: $number, in: 1...10, label: {
                    Text("\(number) notification\(number > 1 ? "s":"") per week")
                })
                Picker(selection: $selection, label: Text("Picker"), content: {
                    Text("swiftUI").tag(1)
                    Text("Vue").tag(2)
                })
                DatePicker(selection: $date, label: {
                    Text("Date")
                })
                Section(header:Text("Email")) {
                    TextField("your email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {self.sumbit.toggle()}){
                        Text("submit")
                    }.alert(isPresented: $sumbit, content: {
                        Alert(title: Text("thanks"), message: Text("email:\(email)"))
                    })
                }
                    
                
            }
            .navigationBarTitle(Text("Settings"))
        }
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
