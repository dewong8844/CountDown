//
//  ViewController.swift
//  Countdown2
//
//  Created by dewong on 10/10/15.
//  Copyright (c) 2015 dewong. All rights reserved.
//

import UIKit

class MyCalendarHelper {
    let userCalendar = Calendar.current
    var endDateComponents = DateComponents()
    var endDate = Date()
    
    func setEndDate(_ year: Int, month: Int, day: Int,
        hour: Int, minute: Int, second: Int) {
            endDateComponents.year = year
            endDateComponents.month = month
            endDateComponents.day = day
            endDateComponents.hour = hour
            endDateComponents.minute = minute
            endDateComponents.second = 0
            endDate = userCalendar.date(from: endDateComponents)!
    }
    
    func schoolDaysToEnd(_ start: Date) -> Int {
        let days:Int = 0
        return days
    }
    
    func timeToEnd(_ startDate: Date) -> DateComponents {
        // userCalendar.timeZone = NSTimeZone(name: "US/Pacific")!
        let diffDateComponents = userCalendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from:startDate, to:endDate)
        return diffDateComponents
    }
    
    func daysToEnd(_ startDate: Date) -> Int {
        // userCalendar.timeZone = NSTimeZone(name: "US/Pacific")!
        let diffDateComponents = userCalendar.dateComponents([.day], from:startDate, to:endDate)
        return diffDateComponents.day!
    }
}

class ViewController: UIViewController {

    @IBOutlet var daysToEnd: UILabel!
    @IBOutlet var timeToEnd: UILabel!
    
    var timer = Timer()
    var hsCalendar = MyCalendarHelper()
    
    @IBAction func exitButtonPressed() {
        print("Exit program")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCountdown()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupCountdown() {
        hsCalendar.setEndDate(2017, month:6, day:1, hour:12, minute:30, second:0)
        let hsTimeToEnd = hsCalendar.timeToEnd(Date())
        let hsDaysToEnd = hsCalendar.daysToEnd(Date())
        
        daysToEnd.text = "\(hsDaysToEnd) Days"
        timeToEnd.text = String.localizedStringWithFormat("%02dh:%02dm:%02ds", hsTimeToEnd.hour!, hsTimeToEnd.minute!, hsTimeToEnd.second!)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(ViewController.subtractTime), userInfo:nil, repeats: true)
    }
    
    func subtractTime() {
        // let now = Date()
        let hsTimeToEnd = hsCalendar.timeToEnd(Date())
        let hsDaysToEnd = hsCalendar.daysToEnd(Date())
        
        // set the countdown
        daysToEnd.text = "\(hsDaysToEnd) Days"
        timeToEnd.text = String.localizedStringWithFormat("%02dh:%02dm:%02ds", hsTimeToEnd.hour!, hsTimeToEnd.minute!, hsTimeToEnd.second!)
        
        if (hsDaysToEnd == 0 && hsTimeToEnd.hour == 0 && hsTimeToEnd.minute == 0 && hsTimeToEnd.second == 0) {
            timer.invalidate()
            
            let alert = UIAlertController(title: "The end is here!",
                message: "Congratuations! This is the end you were hoping for",
                preferredStyle: UIAlertControllerStyle.alert)
            //alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {action in
            //self.setupGame()}))
            present(alert, animated: true, completion: nil)
            
        }
    }

}

