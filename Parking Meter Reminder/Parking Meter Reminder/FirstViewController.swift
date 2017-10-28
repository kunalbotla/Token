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
    //Variables
    
    //Functions
    
    //Objects
    @IBOutlet weak var timeDisplay: UILabel!
   
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBAction func startButton(_ sender: UIButton) {
    }
    
    @IBAction func pauseresumeButton(_ sender: UIButton) {
    }
    
    @IBOutlet weak var pauseresumeButtonOutlet: UIButton!
    
    @IBAction func resetButton(_ sender: UIButton) {
    }
    
    
    
    //Old from Debate Timer
    
    @IBAction func caseButton(_ sender: Any) {
        if timerIsRunning == false {
            seconds = 240
            runTimer()
        }
        else {
            //reset timer set time then run
            resetTimer()
            seconds = 240
            runTimer()
        }
    }
   
    @IBOutlet weak var pauseButtonOutlet: UIButton!
    
    @IBAction func resetButton(_ sender: Any) {
        resetTimer()
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        
        timerIsRunning = true
    }
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            //send alert to inicate timer is up
        }
        else {
            seconds -= 1 //This will count down seconds.
            timeDisplay.text = timeString(time: TimeInterval(seconds)) //This will update the label.
        }
    }
    func resetTimer() {
        timer.invalidate()
        //Reset all variables.
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

