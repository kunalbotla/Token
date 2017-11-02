//
//  FirstViewController.swift
//  Parking Meter Reminder
//
//  Created by Kunal Botla on 10/20/17.
//  Copyright © 2017 Kunal Botla. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
//New Code
    
    //Objects
    @IBOutlet weak var timeDisplay: UILabel!
    
    var seconds = 60
    var timer = Timer()
    var timerIsRunning = false
    var resumeTapped = false
    
   
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBAction func startButton(_ sender: UIButton) {
        runTimer()
    }
    
    @IBAction func pauseresumeButton(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
        }
        else {
            runTimer()
            self.resumeTapped = false
        }
    }
    
    @IBOutlet weak var pauseresumeButtonOutlet: UIButton!
    
    @IBAction func resetButton(_ sender: UIButton) {
        timer.invalidate()
        seconds = 60
        timeDisplay.text = "\(seconds)"
    }
    
    //Functions
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FirstViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1 //This will count down seconds.
        timeDisplay.text = timeString(time: TimeInterval(seconds)) //This will update the label.
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    //<-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

