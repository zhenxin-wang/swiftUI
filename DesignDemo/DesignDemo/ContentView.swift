//
//  ContentView.swift
//  DesignDemo
//
//  Created by DMS on 2021/2/19.
//

import SwiftUI

struct ContentView: View {
    @State var show = false //动画开关
    @State var viewState = CGSize.zero
    var body: some View {
        ZStack {//叠加
            
                
            BlurView(style: .systemMaterial)
            
            TitleView()
                .blur(radius: show ? 20 : 0)//背景模糊效果
            
            CardBottomView()
                .blur(radius: show ? 20 : 0)//背景模糊效果
                .animation(.default)
            CardView()
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)//圆角
                .shadow(radius: 20)//阴影
                .offset(x:0,y:show ? -400 : -40)
                .scaleEffect(0.85)//相对于锚点，按给定的垂直和水平尺寸大小缩放此视图的渲染输出
                .rotationEffect(Angle(degrees: show ? 15 : 0))//视图旋转角度
//                .rotation3DEffect(
//                    Angle(degrees: show ? 50 : 0),
//                    axis: (x: 10.0, y: 10.0, z: 10.0)
//                )
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
                .offset(x: self.viewState.width, y: self.viewState.height)
            CardView()
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)//圆角
                .shadow(radius: 20)//阴影
                .offset(x:0,y:show ? -200 : -20)
                .scaleEffect(0.9)
                .rotationEffect(Angle(degrees: show ? 10 : 0))
//                .rotation3DEffect(
//                    Angle(degrees: show ? 40 : 0),
//                    axis: (x: 10.0, y: 10.0, z: 10.0)
//                )
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
                .offset(x: self.viewState.width, y: self.viewState.height)
            CertificateView()
                .offset(x: self.viewState.width, y: self.viewState.height)
                .scaleEffect(0.95)
                .rotationEffect(Angle(degrees: show ? 5 : 0))
//                .rotation3DEffect(
//                    Angle(degrees: show ? 30 : 0),
//                    axis: (x: 10.0, y: 10.0, z: 10.0)
//                )
                .animation(.spring())
                .onTapGesture {
                    self.show.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            self.viewState = value.translation
                            self.show = true
                        }
                        .onEnded{ value in
                            self.viewState = CGSize.zero
                            self.show = false
                        }
                )

        }
    }
    //        return HStack(content: {//水平排列
    //            ForEach(0..<4,content:{ index in
    //                ZStack(content: {//元素叠加显示
    //                    RoundedRectangle(cornerRadius: 25.0).stroke(lineWidth: 3.0)//视图块
    //                    Text("👻")
    //                })
    //            })
    //        })
    //        .padding()
    //        .foregroundColor(.orange)
    //        .font(Font.largeTitle)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View{
        return VStack {//垂直
            Spacer()
            Text("card view")
            Spacer()
        }
        .frame(width: 340.0, height: 220)
    }
}

struct CertificateView: View {
    var item = Certificate(title: "UI Design", image: "Card1",width:340,height:220)
    var body: some View{
        VStack{
            HStack {//水平
                VStack(alignment: .leading){
                    Text(item.title)
                        .font(.title)//标题字体
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()//组件之间填充空间
                Image("Logo3")
            }
            .padding(.horizontal,20)//水平填充
            .padding(.top,20)//top填充
            Spacer()//组件之间填充空间
            Image(item.image)
                .resizable()//自适应
                .aspectRatio(contentMode: .fit)//图片的显示模式
//                .frame(width: 300, height: 110, alignment: .top)
                .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity)
            
        }
        .frame(width:CGFloat(item.width),height: CGFloat(item.height))
        .background(Color.black)
        .cornerRadius(20)//圆角
        .shadow(radius: 10 )//阴影
    }
}

struct TitleView: View {
    var body: some View {
        VStack{
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Spacer()
            }
            Spacer()
        }.padding()
    }
}

struct CardBottomView: View {
    var body: some View {
        VStack(spacing: 20.0){
            Rectangle()
                .frame(width: 60, height: 6, alignment: .center)
                .cornerRadius(3)
                .opacity(0.1)
            Text("This certificate is proof that Meng To has achieved the UI Design course with approval from a Design+Code instructor.")
                .lineLimit(5)
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .padding(.horizontal)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(30)
        .shadow(radius: 20 )
        .offset(y:UIScreen.main.bounds.height-170)
    }
}
