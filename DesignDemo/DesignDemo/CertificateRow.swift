//
//  CertificateRow.swift
//  DesignDemo
//
//  Created by DMS on 2021/4/6.
//

import SwiftUI

struct CertificateRow: View {
    var certificates = certificateData
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Certificate")
                .font(.system(size: 20))
                .fontWeight(.heavy)
                .padding(.leading, 40)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing:20) {
                    ForEach(certificates) { item in
                        CertificateView(item: item)
                    }
                }
                .padding(20)
                .padding(.leading,20)
            }
        }
    }
}

struct CertificateRow_Previews: PreviewProvider {
    static var previews: some View {
        CertificateRow()
    }
}


struct Certificate: Identifiable {
    var id = UUID()
    var title : String
    var image : String
    var width : Int
    var height: Int
}

let certificateData = [
    Certificate(title: "UI Design", image: "Card1",width:245,height:150),
    Certificate(title: "swiftUI", image: "Card2",width:245,height:150),
    Certificate(title: "Sketch", image: "Card3",width:245,height:150),
    Certificate(title: "Framer", image: "Card4",width:245,height:150)
    
    
]
