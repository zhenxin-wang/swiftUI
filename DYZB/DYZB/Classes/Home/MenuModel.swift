//
//  MenuModel.swift
//  DYZB
//
//  Created by DMS on 2021/4/26.
//

import SwiftUI


class MenuData: ObservableObject {
    @Published var MenuList: [MenuModel] = MenuData.createMenu()
    var count: Int = 0
    static func createMenu() -> [MenuModel]{
         return [MenuModel(id: 0, title: "推荐", selected: true),
                         MenuModel(id: 1, title: "游戏", selected: false),
                         MenuModel(id: 2, title: "娱乐", selected: false),
                         MenuModel(id: 3, title: "趣玩", selected: false),
                         MenuModel(id: 4, title: "美图", selected: false)]
        
        
    }

}

struct MenuModel: Identifiable {
    var id : Int
    var title : String
    var selected : Bool = false
}

