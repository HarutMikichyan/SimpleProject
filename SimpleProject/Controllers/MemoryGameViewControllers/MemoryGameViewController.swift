//
//  MemoryGameViewController.swift
//  SimpleProject
//
//  Created by Harut Mikichyan on 11/8/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import UIKit

class MemoryGameViewController: UIViewController {
    
    lazy private var game: MemoryGame = MemoryGame(numberOfPairOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount: Int = 0 {
        willSet {
            if newValue == cardButtons.count * 3 {
                newGame(isWinner: false)
            }
        }
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        
        if game.matchedCardsCount == (cardButtons.count / 2) {
            newGame(isWinner: true)
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                if card.isMatched {
                    button.isEnabled = false
                }
            }
        }
    }
    
    //MARK: - Emoji Choices
    private var emojiChoices = ["👨🏻‍💻", "👻", "🎃", "👨🏿‍💻", "💩", "💀", "☠️", "🍔", "🏓", "🎾", "🎲", "🏛", "📱", "💻", "⏳"]
    private var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    //MARK: - New Game
    private func newGame(isWinner: Bool) {
        //Change Score
        ProfileViewController.user.score = isWinner ? ProfileViewController.user.score + 1 : ProfileViewController.user.score - 1
        
        let alert = UIAlertController(title: isWinner ? "You Won" : "You Loose", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: isWinner ? "New Game" : "Try Again", style: .default, handler: { (action) in
            self.emojiChoices = ["👻", "🎃", "👨🏿‍💻", "💩", "💀", "☠️", "🍔", "🏓", "🎾", "🎲", "🏛", "💻", "⏳"]
            self.game = MemoryGame(numberOfPairOfCards: (self.cardButtons.count + 1) / 2)
            self.emoji = [Int: String]()
            Card.uniqueIdentifier = 0
            self.flipCount = 0
            
            for cardIndex in self.cardButtons.indices {
                self.cardButtons[cardIndex].isEnabled = true
            }
            self.updateViewFromModel()
        }))
        self.present(alert, animated: true)
    }
}
