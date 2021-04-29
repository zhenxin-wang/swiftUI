//
//  ContentView.swift
//  DYZB
//
//  Created by DMS on 2021/4/25.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 0
    var body: some View {
        
        TabView(selection: $selection){
            Home().tabItem{
                VStack{
                    Image(selection == 0 ? "tabHomeHL" : "tabHome")
                    Text("首页")
                }
            }.tag(0)
            Live().tabItem{
                VStack{
                    Image(selection == 1 ? "tabLivingHL" : "tabLiving")
                    Text("直播")
                }
            }.tag(1)
            Follow().tabItem{
                VStack{
                    Image(selection == 2 ? "tabFocusHL" : "tabFocus")
                    Text("关注")
                }
            }.tag(2)
            Profile().tabItem{
                VStack{
                    Image(selection == 3 ? "tabMineHL" : "tabMine")
                    Text("我的")
                }
            }.tag(3)
        }.accentColor(.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}
