//
//  UpdateDtail.swift
//  DesignDemo
//
//  Created by DMS on 2021/3/12.
//

import SwiftUI

struct UpdateDtail: View {
    
    var title = "swiftUI"
    var text = "loading..."
    var image = "Card1"
    var date = ""
    
    var body: some View {
        VStack(spacing: 20.0) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.heavy)
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height:200)
            Text(text)
                .lineLimit(nil)
                .frame(minWidth:0,maxWidth: .infinity , alignment: .leading)
            Spacer()
        }
        .padding(30)
    }
}

struct UpdateDtail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDtail()
    }
}
