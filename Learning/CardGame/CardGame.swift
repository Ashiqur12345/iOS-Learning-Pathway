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
    private(set) var score : Int
    private(set) var maxAchievableScore : Int
    
    private var faceupCardContent: CardContent?{
        get{ cards.first(where: {$0.isFaceUp && !$0.isMatched})?.content }
    }
    private var unmatchedFaceupCardIndices: [Int]{
        get{ cards.indices.filter({cards[$0].isFaceUp}) }
    }
    
    init(noOfSets: Int, noOfCardsInSet: Int, cardContentMaker : (Int)->CardContent) {
        
        cards = Array<Card>()
        score = 0
        maxAchievableScore = noOfSets * noOfCardsInSet
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
            
            
            if let content = faceupCardContent {
                if cards[chosenIndex].content == content {
                    if unmatchedFaceupCardIndices.count == noOfCardsInSet - 1{
                        for faceupIndex in unmatchedFaceupCardIndices{
                            cards[faceupIndex].isMatched = true
                        }
                        cards[chosenIndex].isMatched = true
                        score += noOfCardsInSet
                    }
                }
                else{
                    for faceupIndex in unmatchedFaceupCardIndices
                    {
                        cards[faceupIndex].isFaceUp = false
                        if cards[faceupIndex].isAlreadySeen{
                            score -= 1
                        }
                        else{
                            cards[faceupIndex].isAlreadySeen = true
                        }
                    }
                }
            }
            else{
                for index in unmatchedFaceupCardIndices
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
        var isAlreadySeen = false
        let content: CardContent
        let id: Int
    }
}
