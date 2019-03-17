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
    @IBOutlet weak var lbl_targetValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateRandomValue()
    }


    @IBAction func showAlert(_ sender: Any) {
        
        let alert = UIAlertController(title: "Result", message: "You select the number: \(currentValue)", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
        
        generateRandomValue()
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        currentValue = lroundf(sender.value)
    }
    
    func generateRandomValue() {
        targetValue = Int.random(in: 1...100)
        lbl_targetValue.text = String(targetValue)
    }
}
