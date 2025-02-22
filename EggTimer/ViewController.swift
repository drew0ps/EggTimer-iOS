//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import UIKit
import AVFoundation
var player: AVAudioPlayer!

class ViewController: UIViewController {
    let eggTimes = ["Soft": 5*60, "Medium": 7*60, "Hard": 12*60]
    var counter = 30
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0

    
    @IBOutlet weak var eggProgress: UIProgressView!

    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        timer.invalidate()
        secondsPassed = 0
        eggLabel.text = "How do you like your eggs?"
        eggProgress.progress = 0.0
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    @IBOutlet weak var eggLabel: UILabel!
    
    @objc func updateCounter() {
        if secondsPassed <= totalTime {

            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            eggLabel.text = "\(round(percentageProgress * 100))%"
            secondsPassed += 1
            eggProgress.progress = Float(percentageProgress)
        } else {
            eggLabel.text = "Done!"
            
            func playSound(soundName: String) {
                let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }
            playSound(soundName: "alarm_sound")

            }
        }
}
