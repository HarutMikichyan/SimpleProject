//
//  MemoryGame.swift
//  SimpleProject
//
//  Created by Harut Mikichyan on 11/8/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import Foundation

class MemoryGame {
    var matchedCardsCount = 0
    var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    init(numberOfPairOfCards: Int) {
        for _ in 0..<numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    matchedCardsCount += 1
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
