//
//  ViewController.swift
//  applePie
//
//  Created by Daria Salamakha on 24.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var exampleLabel: UILabel!
   
    var listOfWords = ["red", "green", "yellow", "pink", "black", "purple"]
    let incorrectMovesAllowed = 7
    var currentGame: Game!
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }


    @IBAction func letterButtonPressed(_ sender: UIButton) {
        
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
          
        updateGameState()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func newRound() {
        
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
          
            enableLetterButtons(true)
            updateUI()
            
        } else {
            
            if totalWins > totalLosses {
                exampleLabel.text = "Congratulations! You are win!"
            } else {
                exampleLabel.text = "Ops.. Try again!"
            }
            
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
      for button in letterButtons {
        button.isEnabled = enable
      }
    }
    
    func updateUI() {
      
        var letters = [String]()
            for letter in currentGame.formattedWord {
                letters.append(String(letter))
            }
        
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        exampleLabel.textColor = UIColor(named: currentGame.word)
        }
    
    func updateGameState() {
      if currentGame.incorrectMovesRemaining == 0 {
        totalLosses += 1
      } else if currentGame.word == currentGame.formattedWord {
        totalWins += 1
      }
        updateUI()
    }
}

