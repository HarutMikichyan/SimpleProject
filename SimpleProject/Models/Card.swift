//
//  Card.swift
//  SimpleProject
//
//  Created by Harut Mikichyan on 11/8/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    init() {
        self.identifier = Card.generatiomUniqueIdentifier()
    }
    
    //MARK: - Generation Identifier
    static var uniqueIdentifier: Int = 0
    static func generatiomUniqueIdentifier() -> Int {
        uniqueIdentifier += 1
        return uniqueIdentifier
    }
}
