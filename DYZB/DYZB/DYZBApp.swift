//
//  DYZBApp.swift
//  DYZB
//
//  Created by DMS on 2021/4/25.
//

import SwiftUI

@main
struct DYZBApp: App {
//    var inits = InitClass()
    var body: some Scene {
        
        WindowGroup {
            
            ContentView()
            
        }
    }
}

//修改navgation 背景颜色
class InitClass {
    init() {
        UINavigationBar.appearance().backgroundColor = .orange
        UINavigationBar.appearance().tintColor = .green
        UINavigationBar.appearance().barTintColor = .yellow
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]
    }
}
