//
//  MemoryGame.swift
//  Memorize
//
//  Created by DMS on 2021/3/30.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    var cards: Array<Card>
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        
        get{ cards.indices.filter { cards[$0].isFaceUp }.only }
        set{
            for index  in cards.indices {
                    cards[index].isFaceUp = index == newValue
            }
        }
    }
    init(numberOfPairsOfCards: Int,cardContentFactory: (Int) ->CardContent) {
        cards = Array<Card>()
        for pairsIndex in 0..<numberOfPairsOfCards{
            let content = cardContentFactory(pairsIndex)
            cards.append(Card( content: content, id: pairsIndex*2))
            cards.append(Card( content: content, id: pairsIndex*2+1))
        }
//        cards.sort(by: T##(MemoryGame<Equatable>.Card, MemoryGame<Equatable>.Card) throws -> Bool)
        
    }
    
    mutating func choose(card: Card){
        print("card chosen: \(card)")
        if let chooseIndex: Int = cards.firstIndex(matching: card),!cards[chooseIndex].isFaceUp,!cards[chooseIndex].isMatched{
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chooseIndex].content == cards[potentialMatchIndex].content {
                    cards[chooseIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chooseIndex].isFaceUp = true
            }else{
                indexOfTheOneAndOnlyFaceUpCard = chooseIndex
            }

        }
        
    }
    
    struct Card: Identifiable{
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
