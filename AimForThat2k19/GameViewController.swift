//
//  ViewController.swift
//  AimForThat2k19
//
//  Created by Sebastian Ortiz Velez on 10/03/2019.
//  Copyright © 2019 Sebastian Ortiz Velez. All rights reserved.
//

import UIKit

class GameViewController : UIViewController {
    
    var currentValue : Int = 50
    var targetValue : Int = 0
    var score : Int = 0
    var round : Int = 0
    
    @IBOutlet weak var lbl_targetValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lbl_round: UILabel!
    @IBOutlet weak var lbl_score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewRound()
    }


    @IBAction func showAlert(_ sender: Any) {
        
        let difference : Int = abs(currentValue - targetValue)
        
        let points = (difference > 0) ? 100 - difference : 500
        
        score += points
        lbl_score.text = String(score)

        
        let alert = UIAlertController(title: "Result", message: "You select the number: \(currentValue), your hit \(points) points", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true)
        
        startNewRound()
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        currentValue = lroundf(sender.value)
    }
    
    func startNewRound() {
        round+=1
        lbl_round.text = String(round)
        
        self.slider.value = 50
        targetValue = Int.random(in: 1...100)
        lbl_targetValue.text = String(targetValue)
    }
}
