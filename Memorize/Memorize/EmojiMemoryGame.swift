//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by DMS on 2021/3/31.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject{
    @Published var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻","🎃","👾"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairsIndex in
            return emojis[pairsIndex]
        }
    }
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
}
