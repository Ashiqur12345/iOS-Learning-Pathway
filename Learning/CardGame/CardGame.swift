//
//  CardGame.swift
//  Learning
//
//  Created by itiw-mac 256 on 11/24/22.
//

import Foundation


struct CardGame<CardContent> where CardContent: Equatable{
    
    private(set) var cards : Array<CardGame.Card>
    private(set) var noOfCardsInSet : Int = 2
    
    private var cardContentBeingMatched: CardContent?
    private var faceupCardIndices: [Int]{
        get{ cards.indices.filter({cards[$0].isFaceUp}) }
    }
    
    init(noOfSets: Int, noOfCardsInSet: Int, cardContentMaker : (Int)->CardContent) {
        
        cards = Array<Card>()
        self.noOfCardsInSet = noOfCardsInSet
        for setIndex in 0..<noOfSets
        {
            for i in 0..<noOfCardsInSet
            {
                cards.append(Card(content: cardContentMaker(setIndex), id: setIndex*noOfCardsInSet + i))
            }
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) -> Void {
        
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let content = cardContentBeingMatched {
                if cards[chosenIndex].content == content {
                    if faceupCardIndices.count == noOfCardsInSet - 1{
                        cardContentBeingMatched = nil
                        for faceupIndex in faceupCardIndices{
                            cards[faceupIndex].isMatched = true
                        }
                        cards[chosenIndex].isMatched = true
                    }
                }
                else{
                    cardContentBeingMatched = nil
                    for faceupIndex in faceupCardIndices
                    {
                        cards[faceupIndex].isFaceUp = false
                    }
                }
            }
            else{
                cardContentBeingMatched = cards[chosenIndex].content
                for index in faceupCardIndices
                {
                    cards[index].isFaceUp = false
                }
            }
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
        var isMatched = false
        var isFaceUp = false
        let content: CardContent
        let id: Int
    }
}
