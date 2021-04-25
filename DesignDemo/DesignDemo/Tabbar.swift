//
//  Tabbar.swift
//  DesignDemo
//
//  Created by DMS on 2021/3/31.
//

import SwiftUI

struct Tabbar: View {
    var body: some View {
        TabView(selection: .constant(1)){
            Home().tabItem {
                VStack {
                    Image(systemName: "person.crop.circle")
                    Text("Home")
                }
            }
            .tag(1)
            ContentView().tabItem {
                VStack {
                    Image(systemName: "creditcard")
                    Text("Certificate")
                }
            }
            .tag(2)
            UpdateList().tabItem {
                VStack {
                    Image(systemName: "rectangle.stack.fill")
                    Text("Updates")
                }
            }
            .tag(3)
            Settings().tabItem {
                VStack{
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }.tag(4)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Tabbar()
            Tabbar()
                .environment(\.colorScheme, .dark)
                .environment(\.sizeCategory, .extraLarge)
        }
    }
}
