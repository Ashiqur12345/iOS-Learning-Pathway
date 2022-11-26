//
//  CardGame.swift
//  Learning
//
//  Created by itiw-mac 256 on 11/24/22.
//

import Foundation


struct CardGame<CardContent> where CardContent: Equatable{
    
    private(set) var cards : Array<CardGame.Card>
    private var otherSelectedCardIndex: Int?
    
    init(noOfPairs: Int, cardContentMaker : (Int)->CardContent) {
        
        cards = Array<Card>()
        
        for pairIndex in 0..<noOfPairs
        {
            cards.append(Card(content: cardContentMaker(pairIndex), id: pairIndex*2))
            cards.append(Card(content: cardContentMaker(pairIndex), id: pairIndex*2 + 1))
        }
        
        shuffleCards()
    }
    
    mutating func shuffleCards() {
        var n = cards.count
        
        while n>1{
            n -= 1
            let k = Int.random(in: 0...n)
            let atN = cards[n]
            cards[n] = cards[k]
            cards[k] = atN
        }
    }
    
    mutating func choose(_ card: Card) -> Void {
        
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
               chosenIndex != otherSelectedCardIndex,
               !cards[chosenIndex].isMatched
        {
            if let otherIndex = otherSelectedCardIndex{
                if cards[chosenIndex].content == cards[otherIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[otherIndex].isMatched = true
                    
                    otherSelectedCardIndex = nil
                    
                    if isGameWon(){
                        cards.removeAll()
                        return
                    }
                }
                else {
                    for i in cards.indices{
                        cards[i].isFaceUp=false
                    }
                }
            }
            
            otherSelectedCardIndex = chosenIndex
            cards[chosenIndex].isFaceUp = true
        }
    }
    
    func isGameWon() -> Bool {
        for i in cards.indices{
            if !cards[i].isMatched {
                return false
            }
        }
        return true
    }
    
    struct Card: Identifiable{
        var isMatched : Bool = false
        var isFaceUp : Bool = false
        var content: CardContent
        var id: Int
    }
}
