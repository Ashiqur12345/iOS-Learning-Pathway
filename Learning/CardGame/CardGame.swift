//
//  CardGame.swift
//  Learning
//
//  Created by itiw-mac 256 on 11/24/22.
//

import Foundation


struct CardGame<CardContent>{
    
    var cards : Array<CardGame.Card>
    
    init(noOfCards: Int, cardContentMaker : (Int)->CardContent) {
        
        cards = Array<Card>()
        
        for pairIndex in 0..<noOfCards
        {
            let c1 = Card(content: cardContentMaker(pairIndex), id: pairIndex*2)
            let c2 = Card(content: cardContentMaker(pairIndex), id: pairIndex*2+1)
            
            cards.append(c1)
            cards.append(c2)
        }
    }
    
    mutating func choose(_ card: Card) -> Void {
        for index in 0..<cards.count{
            if(card.id == cards[index].id){
                cards[index].isFaceUp.toggle()
                print(cards[index].content)
                break
            }
        }
    }
    
    struct Card: Identifiable{
        var isMatched : Bool = false
        var isFaceUp : Bool = Bool.random()
        var content: CardContent
        var id: Int
    }
}
