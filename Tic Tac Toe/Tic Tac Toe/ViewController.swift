//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by PRAVEEN on 12/08/20.
//  Copyright © 2020 Praveen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 1 is X, 2 is O
    var activePlayer = 1
    
    // 0 - empty, 1 - X, 2 - O
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    // Win combinations
    let winningCombinations  = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
    
    var activeGame = true
    
    
    @IBOutlet weak var resultPhrase: UILabel!
    
    @IBOutlet weak var restart: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resultPhrase.isHidden = true
        restart.isHidden = true

    }

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        titleLabel.isHidden = true
        
        let activePosition = sender.tag - 1
        
        if gameState[activePosition] == 0 && activeGame {
            count += 1
            gameState[activePosition] = activePlayer
            
            if activePlayer == 1 {
                 sender.setImage(UIImage(named: "cross.png"), for:[])
                 activePlayer = 2
            } else {
                  sender.setImage(UIImage(named: "nought.png"), for: [])
                activePlayer = 1
            }
        }
        
        // Check for winner
        for combination in winningCombinations {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                activeGame = false
                resultPhrase.isHidden = false
                restart.isHidden = false
                
                if gameState[combination[0]] == 1 {
                    resultPhrase.text = "X Won"
                    
                } else {
                    resultPhrase.text = "O Won"
                    
                }
                break
                
            }
            
            // For Tie game
            if count == 9 {
                activeGame = false
                resultPhrase.isHidden = false
                restart.isHidden = false
                resultPhrase.text = "Tie"
            }
        }
        
    }
    
    
    // Play Button
    @IBAction func playAgain(_ sender: UIButton) {
        titleLabel.isHidden = false
        resultPhrase.isHidden = true
        restart.isHidden = true
        activeGame = true
        activePlayer = 1
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        count = 0
        for i in 1..<10 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.setImage(nil, for:UIControl.State.normal)
            }
        }
    }
    
}

