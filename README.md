# Project 2: Hangman App

## Due
Wednesday, November 9 at 11:59 PM

## Description 
In Project 2, you are going to make an iOS Hangman game. A user should be able to start a game, make guesses for a phrase (list of phrases provided), see their progresses toward the phrase, see a list of previously guessed, incorrect letters, see how many guesses they have left (indicated by a hangman image; basic images provided), be alerted of a win or loss, and start a new game.

## Instructions
We have provided you code to interact with the list of phrases, but you will implement the rest of the features on your own. Fork this repo and push to your forked repo to submit.

## Requirements

You **must** have these views and features. 

###  Start Screen View 
- [x] A UILabel with the name of the game
- [x] A "New Game" Button (takes you to Game View)

###  Game View
- [x] A UILabel that displays the "_"s corresponding to each word in the provided puzzle string
- [x] A UILabel that displays the incorrect guesses thus far
- [x] A TextField (where the user enters a letter as a guess)
- - [x] The user should only be able to guess a single letter
- [x] A "Guess" button which determines whether the letter entered in the textfield is correct or not, and updates the game accordingly
- - [x] If that letter appears in the puzzle string, the corresponding "_" should be replaced by the correctly guessed letter
- - [x] If that letter does not appear in the puzzle string, that letter should be added to a UILabel keeping track of "Incorrect Guesses: ", and the Hangman image should update to represent the number of incorrect guesses
- [x] A square-dimensioned UIImageView that represents the "state" of the Hangman, with appropriate images for each "state"

### Finished Game States, Start New Game
- [x] A win state, indicated by an Alert (Pop up box)
- - [x] Should prevent additional guesses
- [x] A fail state, indicated by an Alert (Pop up box)
- - [x] Should prevent additional guesses
- [x] A "Start Over" button, which starts a new game

## Optional

1. A smart way for the user to guess letters (since a TextField for letter entry is bad UX)
2. Customized design, including, but not limited to, custom images for the Hangman states
3. Anything else that you think will impress us!

## Grading

If you satisfy all of the requirements you will get full credit. Every requirement missed will have 1 point removed from your total score.

The total score is out of 4, and students with the top submissions are eligible to receive one extra-credit point (5/4). These students have the option to have their resumes referred to Apple University recruiting.

