//
//  ViewController.swift
//  AimForThat2k19
//
//  Created by Sebastian Ortiz Velez on 10/03/2019.
//  Copyright © 2019 Sebastian Ortiz Velez. All rights reserved.
//

import UIKit
import QuartzCore

class GameViewController : UIViewController {
    
    var currentValue : Int = 50
    var targetValue : Int = 0
    var score : Int = 0
    var round : Int = 0
    var time : Int = 0
    var timer : Timer?
    
    @IBOutlet weak var lbl_targetValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lbl_round: UILabel!
    @IBOutlet weak var lbl_score: UILabel!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_maxScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSlider()
        startNewGame()
    }


    @IBAction func showAlert(_ sender: Any) {
        
        let difference : Int = abs(currentValue - targetValue)
        
        let points = (difference > 0) ? 100 - difference : 500
        
        score += points

        var tittle : String = ""
        
        switch difference {
        case 0:
            title = "Perfect score"
        case 1...5:
            tittle = "Almost perfect"
        case 6...22:
            tittle = "A bit far"
        default:
            tittle = "Too far away"
        }
        
        let alert = UIAlertController(title: tittle, message: "You select the number: \(currentValue), your hit \(points) points", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler:
        {action in
            self.updateStatistiscs()
            self.startNewRound()
        })
        
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        currentValue = lroundf(sender.value)
    }
    
    func updateStatistiscs() {
        lbl_score.text = String(score)
        round+=1
        lbl_round.text = String(round)
        lbl_time.text = String(time)
    }
    
    func startNewRound() {
        self.slider.value = 50
        time = 60

        targetValue = Int.random(in: 1...100)
        lbl_targetValue.text = String(targetValue)
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:     CAMediaTimingFunctionName.easeIn)
        
        self.view.layer.add(transition, forKey: nil)
        
    }
    
    @IBAction func startNewGame() {
        
        let maxScore = UserDefaults.standard.integer(forKey: "maxScore")
        
        if(score > maxScore){
            UserDefaults.standard.set(score, forKey: "maxScore")
            lbl_maxScore.text = String(score)
        }
        else{
            lbl_maxScore.text = String(maxScore)
        }
        
        score = 0
        round = 0
        time = 60
        
        if(timer != nil) {
            timer?.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        
        updateStatistiscs()
        startNewRound()
    }
    
    @objc func tick(){
        time -= 1
        lbl_time.text = String(time)
        
        if(time == 0){
            let maxScore = UserDefaults.standard.integer(forKey: "maxScore")
            
            if(score > maxScore){
                UserDefaults.standard.set(score, forKey: "maxScore")
            }
            startNewGame()
        }
    }
    
    func setupSlider(){
        let thumbNormalImage = UIImage(named: "SliderThumb-Normal")
        let thumbHiglightedImage = UIImage(named: "SliderThumb-Highlighted")
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackRightImage = UIImage(named: "SliderTrackRight")
    
        self.slider.setThumbImage(thumbNormalImage, for: .normal)
        self.slider.setThumbImage(thumbHiglightedImage, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)

    }
}
