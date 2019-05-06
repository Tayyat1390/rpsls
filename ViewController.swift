//
//  ViewController.swift
//  rps
//
//  Created by Taylor Hoster on 4/25/19.
//  Copyright © 2019 Taylor Hoster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var mostPlayed: UILabel!
    @IBOutlet weak var computerLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var lizardButton: UIButton!
    @IBOutlet weak var spockButton: UIButton!
    
    var wins = 0
    var losses = 0
    var draws = 0
    var _rock = 0
    var _paper = 0
    var _scissors = 0
    var _lizard = 0
    var _spock = 0
   
    var currentGameState: GameState = GameState.start
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgImage = UIImageView(frame: UIScreen.main.bounds)
        bgImage.image = UIImage(named: "bbt.jpg")
        bgImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(bgImage, at: 0)
        
        resetBoard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func changeStats() {
        let astring = String(format: "Wins -%d- Losses -%d- Draws -%d-", wins, losses, draws)
        
        let scoreArray = [_rock, _paper, _scissors, _lizard, _spock]
        
        let _mostPlayed = scoreArray.index(of: scoreArray.max()!)
        let s = getSign(sign: _mostPlayed!)
        
        let mostPlayedString = String(format: "Most Played: %@ %d", s, scoreArray.max()!)
        
        statsLabel.text = astring
        mostPlayed.text = mostPlayedString
    }
    
    func resetBoard() {
        computerLabel.text = "🤖"
        statusLabel.text = "Rock, Paper, Scissors, Lizard, Spock"
        rockButton.isHidden = false
        rockButton.isEnabled = true
        paperButton.isHidden = false
        paperButton.isEnabled = true
        lizardButton.isHidden = false
        lizardButton.isEnabled = true
        spockButton.isHidden = false
        spockButton.isEnabled = true
        scissorsButton.isHidden = false
        scissorsButton.isEnabled = true
        playAgainButton.isHidden = true
        statsLabel.isHidden = false
        mostPlayed.isHidden = false
    }
    
    func play(_ playerTurn: Sign) {
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
        lizardButton.isEnabled = false
        spockButton.isEnabled = false
        
        let opponent = randomSign()
        computerLabel.text = opponent.emoji
        
        currentGameState = playerTurn.takeTurn(opponent)
        
        switch currentGameState {
        case .draw:
            statusLabel.text = "It's a draw."
            draws += 1
        case .lose:
            statusLabel.text = "Sorry, you lose."
            losses += 1
        case .win:
            statusLabel.text = "You win!"
            wins += 1
        case .start:
            statusLabel.text = "Rock, Paper, Scissors, Lizard, Spock?"
        }
        
        switch playerTurn {
        case .rock:
            rockButton.isHidden = false
            paperButton.isHidden = true
            scissorsButton.isHidden = true
            lizardButton.isHidden = true
            spockButton.isHidden = true
            _rock += 1
        case .paper:
            rockButton.isHidden = true
            paperButton.isHidden = false
            scissorsButton.isHidden = true
            lizardButton.isHidden = true
            spockButton.isHidden = true
            _paper += 1
        case .scissors:
            rockButton.isHidden = true
            paperButton.isHidden = true
            scissorsButton.isHidden = false
            lizardButton.isHidden = true
            spockButton.isHidden = true
            _scissors += 1
        case .lizard:
            rockButton.isHidden = true
            paperButton.isHidden = true
            scissorsButton.isHidden = true
            lizardButton.isHidden = false
            spockButton.isHidden = true
            _lizard += 1
        case .spock:
            rockButton.isHidden = true
            paperButton.isHidden = true
            scissorsButton.isHidden = true
            lizardButton.isHidden = true
            spockButton.isHidden = false
            _spock += 1
        }
        
        playAgainButton.isHidden = false
        statsLabel.isHidden = true
        mostPlayed.isHidden = true
        
        changeStats()
        }

    @IBAction func rockSelected(_ sender: Any) {
        play(Sign.rock)
    }
    
    @IBAction func paperSelcted(_ sender: Any) {
        play(Sign.paper)
    }
    
    @IBAction func scissorsSelected(_ sender: Any) {
        play(Sign.scissors)
    }
    
    @IBAction func lizardSelected(_ sender: Any) {
        play(Sign.lizard)
    }
    
    @IBAction func spockSelected(_ sender: Any) {
        play(Sign.spock)
    }
    
    @IBAction func playAgainSelected(_ sender: Any) {
        resetBoard()
    }
}


