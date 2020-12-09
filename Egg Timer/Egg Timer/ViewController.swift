//
//  ViewController.swift
//  Egg Timer
//
//  Created by PRAVEEN on 07/08/20.
//  Copyright © 2020 Praveen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    
    let hardness = [
        "soft": 10,
        "medium": 15,
        "hard": 20,
    ]
    
    var timeRemaining = 0
    var totalTime = 0
    
    var timer = Timer()
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    let defaultlabelTitle = "How do you like your eggs?"
    
    
    // Progress Bar
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // For Rounded corner in Progress bar
        progressBar.layer.cornerRadius = 5
        progressBar.clipsToBounds = true

    }
    

    // Button
    @IBAction func eggsSelected(_ sender: UIButton) {
        
        progressBar.progress = 0.0
        
        titleLabel.text = defaultlabelTitle
        
        timer.invalidate()
        
        let title = sender.currentTitle!

        timeRemaining = hardness[title]!
        
        totalTime = hardness[title]!
        
    
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    // Update Function
    @objc func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            progressBar.progress += 1.0 / Float(totalTime)

        } else {
            timer.invalidate()
            titleLabel.text = "DONE"
        }
        
        // Check if time is <= 5 to play sound
        if timeRemaining <= 5 {
            playSound()
        }
    }
    
    
    
    
    // Reset Button
    @IBAction func resetButton(_ sender: UIButton) {
        titleLabel.text = defaultlabelTitle
        
        timer.invalidate()
        
        progressBar.progress = 0.0
        
        audioPlayer.stop()
        
    }
    
    // Play Sound
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: url!)
        audioPlayer.play()
        audioPlayer.numberOfLoops = -1
    }
    
}

