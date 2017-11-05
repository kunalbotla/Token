//
//  FirstViewController.swift
//  Parking Meter Reminder
//
//  Created by Kunal Botla on 10/20/17.
//  Copyright © 2017 Kunal Botla. All rights reserved.
//

import UIKit
import UserNotifications

class FirstViewController: UIViewController {
    //Objects
    @IBOutlet weak var timeDisplay: UILabel!
    
    var seconds = 0
    var timer = Timer()
    var timerIsRunning = false
    var resumeTapped = false
    
   
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBAction func startButton(_ sender: UIButton) {
        if timerIsRunning == false {
            seconds = Int(timePicker.countDownDuration)
            runTimer()
            timerIsRunning = true
            //self.startButtonOutlet.isEnabled = false
        }
    }
    
    @IBOutlet weak var startButtonOutlet: UIButton!
    
    @IBAction func pauseresumeButton(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.pauseresumeButtonOutlet.setTitle("Resume", for: .normal)
        }
        else {
            runTimer()
            self.resumeTapped = false
            self.pauseresumeButtonOutlet.setTitle("Pause", for: .normal)
        }
    }
    
    @IBOutlet weak var pauseresumeButtonOutlet: UIButton!
    
    @IBAction func resetButton(_ sender: UIButton) {
        timer.invalidate()
        seconds = 0
        timeDisplay.text = timeString(time: TimeInterval(seconds))
        timerIsRunning = false
        pauseresumeButtonOutlet.isEnabled = false
    }
    
    //Functions
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FirstViewController.updateTimer)), userInfo: nil, repeats: true)
        timerIsRunning = true
        pauseresumeButtonOutlet.isEnabled = true
    }
    
    @objc func updateTimer() {
        sendAlert()
        if seconds < 1 {
            timer.invalidate()
        }
        else {
            seconds -= 1 //This will count down seconds.
            timeDisplay.text = timeString(time: TimeInterval(seconds)) //This will update the label.
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func sendAlert() {
        if seconds == 0 {
            let content = UNMutableNotificationContent()
            content.title = "Your Parking Meter"
            content.subtitle = "Your Parking Meter is Out of Time"
            content.body = "0 hours, 0 minutes, 0 seconds"
            content.badge = 1
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        if seconds == 120 {
            //Send Notification/Alert TIME IS AT 2 MIN
        }
    }
    //<-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pauseresumeButtonOutlet.isEnabled = false
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

