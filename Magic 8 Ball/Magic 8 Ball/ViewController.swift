//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Dona Ganzorig on 8/9/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let ballArray = [ "ball1", "ball2", "ball3", "ball4", "ball5" ]

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func askButtonPressed(_ sender: Any) {
        newBallImage()
    }
    
    func newBallImage() {
        let randomBallNumber = Int.random(in: 0 ... 4)
        imageView.image = UIImage(named: ballArray[randomBallNumber])
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        newBallImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newBallImage()
    }


}

