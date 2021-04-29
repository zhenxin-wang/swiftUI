//
//  Home.swift
//  DYZB
//
//  Created by DMS on 2021/4/25.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView{

            PageTitleView(MenuData: MenuData())
                .offset(x: 0, y: 0)
//            Spacer()
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action:{}){
                                        Image("logo")
                                    },
                            trailing:
                                HStack(spacing:20){
                                    Button(action:{}){
                                        Image("Image_scan")
                                    }
                                    Button(action:{}){
                                        Image("btn_search")
                                    }
                                    Button(action:{}){
                                        Image("image_my_history")
                                    }
                                }
            )
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
