//
//  ViewController.swift
//  Egg Timer
//
//  Created by Михаил Позялов on 24.01.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    @IBOutlet weak var label: UILabel!
    let eggsTimer = ["Soft": 300, "Medium": 420, "Hard": 720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBAction func dardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.titleLabel?.text
        totalTime = eggsTimer[hardness ?? ""]!
        
        progressView.progress = 0.0
        secondsPassed = 0
        label.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    @IBOutlet weak var progressView: UIProgressView!
    
    @objc func onTimerFires() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressView.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            timer.invalidate()
            label.text = "DONE!"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

