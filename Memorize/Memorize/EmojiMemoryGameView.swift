//
//  ContentView.swift
//  Memorize
//
//  Created by DMS on 2021/3/29.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
            Grid(viewModel.cards) { card in
                
                CardView(card: card).onTapGesture{
                    viewModel.choose(card: card)
                }
                .padding()
            }
            .padding()
            .foregroundColor(.orange)
    }
}

struct CardView: View{

    var card : MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    func body(for size: CGSize) -> some View{
        ZStack{
            if card.isFaceUp{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            }else{
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
                
            }
        }
        .font(Font.system(size: self.fonSize(for: size)))
    }
    
    let cornerRadius:CGFloat = 10.0
    let edgeLineWidth:CGFloat = 3.0
    
    func fonSize(for size: CGSize) -> CGFloat{
        min(size.width, size.height) * 0.75
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
