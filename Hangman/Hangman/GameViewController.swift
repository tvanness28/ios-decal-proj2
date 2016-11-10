//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var screen = UIScreen.main.bounds.size
    
    var top_screen = UIView()
    var mid_screen = UIView()
    
    var curAnswerLabel = UILabel()
    var curMissLabel = UILabel()
    var hangManImageView = UIImageView(image: #imageLiteral(resourceName: "hangman1.gif"))
    var hangManImages: [UIImage] = [#imageLiteral(resourceName: "hangman1.gif"),#imageLiteral(resourceName: "hangman2.gif"),#imageLiteral(resourceName: "hangman3.gif"),#imageLiteral(resourceName: "hangman4.gif"),#imageLiteral(resourceName: "hangman5.gif"),#imageLiteral(resourceName: "hangman6.gif"),#imageLiteral(resourceName: "hangman7.gif")]
    var guessView = UITextField()
    var guessButton = UIButton(type: UIButtonType.roundedRect)
    var winAlert = UIAlertController(title: "Winner!", message: "Congratulations! You're a winner!", preferredStyle: UIAlertControllerStyle.alert)
    var loseAlert = UIAlertController(title: "Defeat!", message: "Sorry! Better luck next time.", preferredStyle: UIAlertControllerStyle.alert)
    
    var letterCollection: UICollectionView!
    let reuseIdentifier = "cell"
    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var curHangMan: Int = 0
    var curPhrase: String = ""
    var curRevealed: String = ""
    var curMissed: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startOverAction = UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default) { (action) in
            self.setup_new_game()
        }
        
        winAlert.addAction(startOverAction)
        loseAlert.addAction(startOverAction)
        
        self.view.backgroundColor = UIColor.white
        
        top_screen.frame = CGRect(x: 0, y: 0, width: screen.width , height: (0.22222 * screen.height))
        top_screen.backgroundColor = UIColor(hue: 0.5417, saturation: 0.38, brightness: 1, alpha: 1.0)
        self.view.addSubview(top_screen)
        
        top_screen.addSubview(hangManImageView)
        hangManImageView.translatesAutoresizingMaskIntoConstraints = false
        
        hangManImageView.centerXAnchor.constraint(equalTo: top_screen.centerXAnchor).isActive = true
        hangManImageView.topAnchor.constraint(equalTo: top_screen.topAnchor, constant: 50).isActive = true
        
        mid_screen.frame = CGRect(x: 0, y: (0.2222 * screen.height), width: screen.width , height: (0.4444 * screen.height))
        mid_screen.backgroundColor = UIColor(hue: 0.5417, saturation: 0.38, brightness: 1, alpha: 1.0)
        self.view.addSubview(mid_screen)
        
        curAnswerLabel.numberOfLines = 0
        curAnswerLabel.font = UIFont.boldSystemFont(ofSize: 32)
        mid_screen.addSubview(curAnswerLabel)
        curAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        curAnswerLabel.centerXAnchor.constraint(equalTo: mid_screen.centerXAnchor).isActive = true
        curAnswerLabel.centerYAnchor.constraint(equalTo: mid_screen.centerYAnchor).isActive = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 40, height: 40)
        
        
        letterCollection = UICollectionView(frame: CGRect(x: 0, y: (0.6666 * screen.height), width: screen.width , height: (0.33333 * screen.height)), collectionViewLayout: layout)
        letterCollection.delegate = self
        letterCollection.dataSource = self
        letterCollection.register(LetterSelector.self, forCellWithReuseIdentifier: "cell")
        letterCollection.backgroundColor = UIColor(hue: 0.5417, saturation: 1, brightness: 1, alpha: 1.0)
        self.view.addSubview(letterCollection)
        
        setup_new_game()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        screen = UIScreen.main.bounds.size
        if UIDevice.current.orientation.isLandscape {
            top_screen.frame = CGRect(x: 0, y: 0, width: 150 , height: (0.6666 * screen.height))
            mid_screen.frame = CGRect(x: 150, y: 0, width: screen.width - 150 , height: (0.6666 * screen.height))
            letterCollection.frame = CGRect(x: 0, y: (0.6666 * screen.height), width: screen.width , height: (0.33333 * screen.height))
        } else {
            top_screen.frame = CGRect(x: 0, y: 0, width: screen.width , height: (0.22222 * screen.height))
            mid_screen.frame = CGRect(x: 0, y: (0.2222 * screen.height), width: screen.width , height: (0.4444 * screen.height))
            letterCollection.frame = CGRect(x: 0, y: (0.6666 * screen.height), width: screen.width , height: (0.33333 * screen.height))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alphabet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LetterSelector = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LetterSelector
        let alpha_i = alphabet.index(alphabet.startIndex, offsetBy: indexPath.row)
        cell.textLabel.text = alphabet[alpha_i]
        cell.chosen = false
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: LetterSelector = collectionView.cellForItem(at: indexPath) as! LetterSelector
        if let letter = cell.textLabel.text {
            if !cell.chosen {
                letter_clicked(letter)
                cell.chosen = true
                cell.backgroundColor = UIColor(hue: 0.5417, saturation: 1, brightness: 1, alpha: 1.0)
            }
        }
    }
    
    func setup_new_game() {
        // Do any additional setup after loading the view.
        curHangMan = 0
        
        hangManImageView.image = #imageLiteral(resourceName: "hangman1.gif")
        
        letterCollection.reloadData()
        
        let hangmanPhrases = HangmanPhrases()
        if let phrase = hangmanPhrases.getRandomPhrase() {
            
            HiddenChar.reset_hidden_phrase()
            hidden_phrase = [HiddenChar]()
            
            for i in phrase.characters {
                hidden_phrase.append(HiddenChar(String(i)))
            }
                        
            curAnswerLabel.text = getCurrentPhrase(hidden_phrase)
            
        }

    }
    
    func letter_clicked(_ letter: String) {
        if letter != "" && letter != " " && letter.characters.count == 1 {
            var correct_guess: Bool = false
            for hidden_char in hidden_phrase {
                if hidden_char.reveal_letter(letter) {
                    correct_guess = true
                }
            }
            if correct_guess {
                curAnswerLabel.text = getCurrentPhrase(hidden_phrase)
                if HiddenChar.num_unrevealed == 0 {
                    present(winAlert, animated: true)
                }
            } else {
                if HiddenChar.new_incorrect_guess(letter) {
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
    }
    
    func getCurrentPhrase(_ phrase: [HiddenChar]) -> String {
        var cur_word: String = ""
        for i in phrase {
            if i.revealed == " " {
                cur_word.append("\n")
            } else {
                cur_word.append(i.revealed)
                cur_word.append(" ")
            }
        }
        return cur_word
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
