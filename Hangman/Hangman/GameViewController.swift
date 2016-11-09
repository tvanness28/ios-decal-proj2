//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var curAnswerLabel = UILabel()
    var curMissLabel = UILabel()
    var hangManImageView = UIImageView(image: #imageLiteral(resourceName: "hangman1.gif"))
    var hangManImages: [UIImage] = [#imageLiteral(resourceName: "hangman1.gif"),#imageLiteral(resourceName: "hangman2.gif"),#imageLiteral(resourceName: "hangman3.gif"),#imageLiteral(resourceName: "hangman4.gif"),#imageLiteral(resourceName: "hangman5.gif"),#imageLiteral(resourceName: "hangman6.gif"),#imageLiteral(resourceName: "hangman7.gif")]
    var guessView = UITextField()
    var guessButton = UIButton(type: UIButtonType.roundedRect)
    var winAlert = UIAlertController(title: "Winner!", message: "Congratulations! You're a winner!", preferredStyle: UIAlertControllerStyle.alert)
    var loseAlert = UIAlertController(title: "Defeat!", message: "Sorry! Better luck next time.", preferredStyle: UIAlertControllerStyle.alert)
    
    var curHangMan: Int = 0
    var curPhrase: String = ""
    var curRevealed: String = ""
    var curMissed: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        self.view.addSubview(hangManImageView)
        hangManImageView.translatesAutoresizingMaskIntoConstraints = false
        
        hangManImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        hangManImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        
        let startOverAction = UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default) { (action) in
            self.setup_new_game()
        }
        
        winAlert.addAction(startOverAction)
        loseAlert.addAction(startOverAction)
        
        curAnswerLabel.numberOfLines = 0
        curAnswerLabel.font = UIFont.boldSystemFont(ofSize: 32)
        self.view.addSubview(curAnswerLabel)
        curAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
            
        curAnswerLabel.topAnchor.constraint(equalTo: hangManImageView.bottomAnchor, constant: 25).isActive = true
        curAnswerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        curAnswerLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        guessView.placeholder = "Take a guess!"
        guessView.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(guessView)
        guessView.translatesAutoresizingMaskIntoConstraints = false
            
        guessView.topAnchor.constraint(equalTo: curAnswerLabel.bottomAnchor, constant: 25).isActive = true
        guessView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            
        guessButton.setTitle("Guess", for: UIControlState.normal)
        guessButton.addTarget(self, action: #selector(guessPressed), for: .touchUpInside)
        self.view.addSubview(guessButton)
        guessButton.translatesAutoresizingMaskIntoConstraints = false
            
        guessButton.topAnchor.constraint(equalTo: guessView.bottomAnchor, constant: 25).isActive = true
        guessButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        curMissLabel.font = UIFont.boldSystemFont(ofSize: 32)
        self.view.addSubview(curMissLabel)
        curMissLabel.translatesAutoresizingMaskIntoConstraints = false
            
        curMissLabel.topAnchor.constraint(equalTo: guessButton.bottomAnchor, constant: 25).isActive = true
        curMissLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        curMissLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        setup_new_game()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup_new_game() {
        // Do any additional setup after loading the view.
        curHangMan = 0
        
        hangManImageView.image = #imageLiteral(resourceName: "hangman1.gif")
        
        let hangmanPhrases = HangmanPhrases()
        if let phrase = hangmanPhrases.getRandomPhrase() {
            
            HiddenChar.reset_hidden_phrase()
            hidden_phrase = [HiddenChar]()
            
            for i in phrase.characters {
                hidden_phrase.append(HiddenChar(String(i)))
            }
            
            print(phrase.characters.count)
            print(HiddenChar.num_unrevealed)
            
            curAnswerLabel.text = getCurrentPhrase(hidden_phrase)
            
            curMissLabel.text = getCurrentMisses()
            
        }

    }
    
    func guessPressed(_ sender: UIButton!) {
        if let chosen_char = guessView.text {
            if chosen_char != "" && chosen_char != " " && chosen_char.characters.count == 1 {
                var correct_guess: Bool = false
                for hidden_char in hidden_phrase {
                    if hidden_char.reveal_letter(chosen_char) {
                        correct_guess = true
                    }
                }
                if correct_guess {
                    print(HiddenChar.num_unrevealed)
                    curRevealed = getCurrentPhrase(hidden_phrase)
                    curAnswerLabel.text = curRevealed
                    if HiddenChar.num_unrevealed == 0 {
                        present(winAlert, animated: true)
                    }
                } else {
                    if HiddenChar.new_incorrect_guess(chosen_char) {
                        curMissed = getCurrentMisses()
                        curMissLabel.text = curMissed
                        curHangMan += 1
                        if curHangMan >= hangManImages.count {
                            present(loseAlert, animated: true)
                        } else {
                            hangManImageView.image = hangManImages[hangManImages.index(hangManImages.startIndex, offsetBy: curHangMan)]
                        }
                    }
                }
            }
            guessView.text = ""
        }
    }
    
    func getCurrentPhrase(_ phrase: [HiddenChar]) -> String {
        var result: String = ""
        for i in phrase {
            if i.revealed == " " {
               result.append("\n")
            } else {
                result.append(i.revealed)
                result.append(" ")
            }
        }
        return result
    }
    
    func getCurrentMisses() -> String {
        var result: String = ""
        for i in HiddenChar.incorrect_guesses {
            result.append(i)
            result.append(" ")
        }
        return result
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
