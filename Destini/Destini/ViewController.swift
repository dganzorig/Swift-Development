//
//  ViewController.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Our strings
    let story1 = "Your car has blown a tire on a winding road in the middle of nowhere with no cell phone reception. You decide to hitchhike. A rusty pickup truck rumbles to a stop next to you. A man with a wide brimmed hat with soulless eyes opens the passenger door for you and asks: \"Need a ride, boy?\"."
    let answer1a = "I\'ll hop in. Thanks for the help!"
    let answer1b = "Better ask him if he\'s a murderer first."
    
    
    let story2 = "He nods slowly, unphased by the question."
    let answer2a = "At least he\'s honest. I\'ll climb in."
    let answer2b = "Wait, I know how to change a tire."
    
    let story3 = "As you begin to drive, the stranger starts talking about his relationship with his mother. He gets angrier and angrier by the minute. He asks you to open the glovebox. Inside you find a bloody knife, two severed fingers, and a cassette tape of Elton John. He reaches for the glove box."
    let answer3a = "I love Elton John! Hand him the cassette tape."
    let answer3b = "It\'s him or me! You take the knife and stab him."
    
    let story4 = "What? Such a cop out! Did you know traffic accidents are the second leading cause of accidental death for most adult age groups?"
    let story5 = "As you smash through the guardrail and careen towards the jagged rocks below you reflect on the dubious wisdom of stabbing someone while they are driving a car you are in."
    let story6 = "You bond with the murderer while crooning verses of \"Can you feel the love tonight\". He drops you off at the next town. Before you go he asks you if you know any good places to dump bodies. You reply: \"Try the pier.\""
    
    
    // UI Elements linked to the storyboard
    @IBOutlet weak var topButton: UIButton!         // Has TAG = 1
    @IBOutlet weak var bottomButton: UIButton!      // Has TAG = 2
    @IBOutlet weak var storyTextView: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
    let initialStoryIndex = 1
    var storyIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restart()
        updateUI()
    }

    
    // User presses one of the buttons
    @IBAction func buttonPressed(_ sender: UIButton) {
    
        switch sender.tag {
            case 1:
                // top button
                changeStoryIndex(isLeft: true)
                updateUI()
                break
            case 2:
                // bottom button
                changeStoryIndex(isLeft: false)
                updateUI()
                break
            default:
                print("Not a valid button tag!")
        }
    
    }
    
    @IBAction func restartPressed(_ sender: UIButton) {
        restart()
        updateUI()
    }
    
    func changeStoryIndex(isLeft: Bool) {
        let storyAfterDictionary = [
            1: [3, 2],
            2: [3, 4],
            3: [6, 5]
        ]
        
        if storyAfterDictionary.keys.contains(storyIndex) {
            storyIndex = isLeft ? storyAfterDictionary[storyIndex]![0] : storyAfterDictionary[storyIndex]![1]
        }
    }
    
    func updateUI() {
        let storyDictionary = [
            1: [story1, answer1a, answer1b],
            2: [story2, answer2a, answer2b],
            3: [story3, answer3a, answer3b],
            4: [story4, nil, nil],
            5: [story5, nil, nil],
            6: [story6, nil, nil],
        ]
        storyTextView.text = storyDictionary[storyIndex]![0]!
        
        // update top button
        let topText = storyDictionary[storyIndex]![1]
        topButton.isHidden = (topText == nil)
        if (topText != nil) { topButton.setTitle(topText, for: .normal) }
        
        // update bottom button
        let bottomText = storyDictionary[storyIndex]![2]
        bottomButton.isHidden = (bottomText == nil)
        if (bottomText != nil) { bottomButton.setTitle(bottomText, for: .normal) }
        
        // determine whether to give option to restart
        restartButton.isHidden = (topText != nil || bottomText != nil)
    }

    func restart() {
        storyIndex = initialStoryIndex
    }

}

