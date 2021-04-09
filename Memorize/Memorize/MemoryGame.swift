//
//  MemoryGame.swift
//  Memorize
//
//  Created by DMS on 2021/3/30.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int,cardContentFactory: (Int) ->CardContent) {
        cards = Array<Card>()
        for pairsIndex in 0..<numberOfPairsOfCards{
            let content = cardContentFactory(pairsIndex)
            cards.append(Card( content: content, id: pairsIndex*2))
            cards.append(Card( content: content, id: pairsIndex*2+1))
        }
        
    }
    
    func choose(card: Card){
        print("card chosen: \(card)")
    }
    struct Card: Identifiable{
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
