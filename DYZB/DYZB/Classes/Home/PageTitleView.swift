//
//  PageTitleView.swift
//  DYZB
//
//  Created by DMS on 2021/4/26.
//

import SwiftUI

struct PageTitleView: View {
    @ObservedObject var MenuData: MenuData
    @State var oldIndex: Int = 0
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(MenuData.MenuList){ item in
                        TitleView(index: item.id,oIndex: $oldIndex)
                            .environmentObject(self.MenuData)
                    }
                }
            }
            .frame(height:50)
            Spacer()
        }
    }
}

struct TitleView: View {
    @EnvironmentObject var MenuData: MenuData
    var index: Int
    @Binding var oIndex: Int
    var body: some View {
        VStack{
            Text(self.MenuData.MenuList[index].title).padding(.top)
            Rectangle()
                .frame(width: UIScreen.main.bounds.width/4, height: 5, alignment: .center)
                .foregroundColor(self.MenuData.MenuList[index].selected ? .orange : .clear)
                .animation(.spring())
                .transition(.slide)
        }.frame(minWidth:UIScreen.main.bounds.width/4,maxWidth: .infinity,minHeight: 50,maxHeight: .infinity)
        .onTapGesture {
            if oIndex != index{
                self.MenuData.MenuList[index].selected.toggle()
                self.MenuData.MenuList[oIndex].selected.toggle()
                oIndex = index
            }
            
        }
    }
}

struct PageTitleView_Previews: PreviewProvider {
    static var previews: some View {
        PageTitleView(MenuData: MenuData())
    }
}
