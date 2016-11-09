//
//  HiddenChar.swift
//  Hangman
//
//  Created by Timothy Van Ness on 11/9/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HiddenChar {
    static var incorrect_guesses = [String]()
    static var num_unrevealed: Int = 0
    static let place_hold: String = "_"
    var revealed: String
    var letter: String
    
    init(_ letter: String) {
        if letter != " " {
            self.revealed = HiddenChar.place_hold
            HiddenChar.num_unrevealed += 1
        } else {
            self.revealed = letter
        }
        self.letter = letter
    }
    
    static func reset_hidden_phrase() {
        incorrect_guesses = [String]()
        num_unrevealed = 0
    }
    
    static func new_incorrect_guess(_ guess: String) -> Bool {
        if !incorrect_guesses.contains(guess) {
            incorrect_guesses.append(guess)
            return true
        }
        return false
    }
    
    func reveal_letter(_ guess: String) -> Bool {
        if letter == guess {
            if revealed == HiddenChar.place_hold {
                HiddenChar.num_unrevealed -= 1
            }
            revealed = letter
            return true
        }
        return false
    }
}

var hidden_phrase = [HiddenChar]()
