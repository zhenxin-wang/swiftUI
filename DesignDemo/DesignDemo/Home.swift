//
//  Home.swift
//  DesignDemo
//
//  Created by DMS on 2021/2/23.
//

import SwiftUI

let statusBarHeight = CGFloat(20)
let srceen = UIScreen.main.bounds

struct Home: View {
    @State var show = false
    @State var showProfile = false
    
    var body: some View {
        ZStack(alignment: .topLeading ) {//叠加
            HomeList()
                .blur(radius: show ? 20 : 0)
                .scaleEffect(showProfile ? 0.95 :1)
                .animation(.default)
                
            ContentView()
//                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 20 )
                .animation(.spring())
                .offset(y: self.showProfile ? statusBarHeight+40 : UIScreen.main.bounds.height)
            HStack{
                MenuButton(show: $show)
                    .offset(x:-40,y:showProfile ? statusBarHeight : 70)
                    .animation(.default)
                Spacer()
                MenuRight(show: $showProfile)
                    .offset(y:showProfile ? statusBarHeight : 70)
                    .animation(.default)
   
            }
            MenuView(show: $show)
        }
        .background(Color("background1"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home().previewDevice("iPhone SE")
            Home().previewDevice("iPhone Xr")
            Home().previewDevice("iPad Pro (9.7-inch)")
            
        }
    }
}

struct MenuRow: View {
    var image = "creditcard"
    var text = "My Account"
    var body: some View {
        HStack {
            Image(systemName: image)
                
                .imageScale(.large)
                .frame(width: 32, height: 32)
            
            Text(text)
                .foregroundColor(.primary)
                .font(.headline)
            Spacer()
                
        }
    }
}

struct Menu:Identifiable {
    var id = UUID()
    var title : String
    var icon : String
    
}

let menuData = [
    Menu(title: "My Account", icon: "person.crop.circle"),
    Menu(title: "Billing", icon: "creditcard"),
    Menu(title: "Settings", icon: "gear"),
    Menu(title: "Team", icon: "person.and.person"),
    Menu(title: "sign out", icon: "arrow.uturn.down"),
]

struct MenuView: View {
    var menuItems = ["My Account","Billing","Team","sign out"]
    var menu = menuData
    @Binding var show : Bool
    @State var settings = false
    var body: some View {
        HStack {
            VStack(alignment: .leading ,spacing: 20) {//垂直
                ForEach(menu){ item in
                    if (item.title == "Settings") {
                        Button(action: {self.settings = true}, label: {
                            MenuRow(image: item.icon, text: item.title)
                        }).sheet(isPresented: self.$settings, content: {
                            Settings()
                        })
                    }else{
                        MenuRow(image: item.icon, text: item.title)
                    }
                    
                }
                
                Spacer()
            }
            
            .padding(.top, 20)
            .padding(30)
            .frame(minWidth: 0,  maxWidth: 360 )
            .background(BlurView(style: .systemMaterial))
            .cornerRadius(30)
            .padding(.trailing,60)
            .shadow(radius: 20 )
            .rotation3DEffect(
                Angle(degrees: self.show ? 0 :60),
                axis: (x: 0.0, y: 10.0, z: 0.0)
            )
            .animation(.default)
            .offset(x: self.show ? 0 : -UIScreen.main.bounds.width)
            .onTapGesture{
                self.show.toggle()
            }
        }
        .padding(.top,statusBarHeight)
        
    }
}
//圆形按钮
struct CircleButton: View {
    var icon = "person.crop.circle"
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.primary)
        }
        .frame(width: 44, height: 44)
        .background(BlurView(style: .systemThinMaterial))
        .cornerRadius(30)
        .shadow(radius: 10 )
    }
}
//左边按钮
struct MenuButton: View {
    @Binding var show : Bool
    var body: some View {
        Button(action: {self.show.toggle()}){
            HStack {
                Spacer()
                Image(systemName: "list.dash")
                    .foregroundColor(.primary)
            }
            .padding(.trailing,20)
            .frame(width: 90, height: 60)
            .background(BlurView(style: .systemThinMaterial))
            .cornerRadius(30)
            .shadow(radius: 10 )
        }
    }
}
//右边菜单
struct MenuRight: View {
    @Binding var show : Bool
    
    @State var updateListShow = false
    var body: some View {
        HStack{
            Button(action: {self.show.toggle()}){
                CircleButton(icon: "person.crop.circle")
            }
            Button(action: {self.updateListShow = true}){
                CircleButton(icon: "bell")
            }
            .sheet(isPresented: self.$updateListShow, content: {
                UpdateList()
            })
            .padding(.trailing,10)
        }
    }
}
