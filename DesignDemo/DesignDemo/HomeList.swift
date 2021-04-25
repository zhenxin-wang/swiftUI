//
//  HomeList.swift
//  DesignDemo
//
//  Created by DMS on 2021/3/10.
//

import SwiftUI

struct HomeList: View {
    @State var showCourseContent = false
    var courses = courseData
    var body: some View {
        
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Course")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        Text("22 Courses")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.leading,70)
    //            .padding(.bottom,30)
                ScrollView(Axis.Set.horizontal, showsIndicators: false) {
                    HStack(spacing: 30){//间隔
                        ForEach(courses) { item in
                            
                            Button(action:{
                                self.showCourseContent = true
                            }){
                                GeometryReader{ geometry in
                                    CourseView(
                                        title: item.title,
                                        image: item.image,
                                        bgColor: item.bgColor,
                                        shaDowColor: item.shaDowColor)
                                        .rotation3DEffect(
                                            Angle(degrees: Double(geometry.frame(in: .global).minX - 40) / -40),
                                            axis: (x: 0.0, y: 10.0, z: 0.0))
                                }
                                .frame(width:300, height:360)
                                
                            }.sheet(isPresented: self.$showCourseContent){//事件点击响应块
                                ContentView()
                            }
                        }
                        
                    }
                    .padding(.leading,30)
                    .padding(.top,30)
                    .padding(.bottom,70)
                    Spacer()
                }
                CertificateRow()
            }
            .padding(.top,70)
        }
        
    }
}

struct HomeList_Previews: PreviewProvider {
    static var previews: some View {
        HomeList()
    }
}
//卡片视图
struct CourseView: View {
    var title : String
    var image : String
    var bgColor : Color
    var shaDowColor : Color
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.white)
                .padding(20)
                .lineLimit(4)
                .padding(.trailing,50)
            Spacer()
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 200)
                .padding(.bottom,20)
        }
        .background(bgColor)
        .cornerRadius(30)
        .shadow(color: shaDowColor, radius: 10, x: 0, y: 10)
        .frame(width: 300, height: 360)
    }
}

struct Course:Identifiable {
    var id = UUID()
    var title : String
    var image : String
    var bgColor : Color
    var shaDowColor : Color
}
let courseData = [
    Course(
        title: "build an with app SwiftUi", image: "Card1", bgColor: Color("card1"),shaDowColor:Color("card1")
    ),
    Course(title: "build an with app java", image: "Card2", bgColor: Color("card2"),shaDowColor:Color("card2")),
    Course(title: "build an with app vue", image: "Card3", bgColor: Color("card3"),shaDowColor:Color("card3")),
    Course(title: "build an with app js", image: "Card4", bgColor: Color("card4"),shaDowColor:Color("card4")),
    Course(title: "build an with app html", image: "Card5", bgColor: Color("card5"),shaDowColor:Color("card5"))
]

