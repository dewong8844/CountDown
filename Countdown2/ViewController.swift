//
//  ViewController.swift
//  Countdown2
//
//  Created by dewong on 10/10/15.
//  Copyright (c) 2015 dewong. All rights reserved.
//

import UIKit

class MyCalendarHelper {
    let userCalendar = NSCalendar.currentCalendar()
    var endDateComponents = NSDateComponents()
    var endDate = NSDate()
    
    func setEndDate(year: Int, month: Int, day: Int,
        hour: Int, minute: Int, second: Int) {
            endDateComponents.year = year
            endDateComponents.month = month
            endDateComponents.day = day
            endDateComponents.hour = hour
            endDateComponents.minute = minute
            endDateComponents.second = 0
            endDate = userCalendar.dateFromComponents(endDateComponents)!
    }
    
    func schoolDaysToEnd(start: NSDate) -> Int {
        var days:Int = 0
        return days
    }
    
    func timeToEnd(startDate: NSDate) -> NSDateComponents {
        // userCalendar.timeZone = NSTimeZone(name: "US/Pacific")!
        let unit:NSCalendarUnit = .CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond
        let startDateComponents = userCalendar.components(unit, fromDate: startDate)
        let diffDateComponents = userCalendar.components(unit, fromDate:startDate, toDate:endDate, options:nil)
        return diffDateComponents
    }
    
    func daysToEnd(startDate: NSDate) -> Int {
        // userCalendar.timeZone = NSTimeZone(name: "US/Pacific")!
        let unit:NSCalendarUnit = .CalendarUnitDay
        let startDateComponents = userCalendar.components(unit, fromDate: startDate)
        let diffDateComponents = userCalendar.components(unit, fromDate:startDate, toDate:endDate, options:nil)
        return diffDateComponents.day
    }
}

class ViewController: UIViewController {

    @IBOutlet var daysToEnd: UILabel!
    @IBOutlet var timeToEnd: UILabel!
    
    var timer = NSTimer()
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
        hsCalendar.setEndDate(2019, month:6, day:10, hour:22, minute:05, second:0)
        let hsTimeToEnd = hsCalendar.timeToEnd(NSDate())
        let hsDaysToEnd = hsCalendar.daysToEnd(NSDate())
        
        daysToEnd.text = "\(hsDaysToEnd) Days"
        timeToEnd.text = String.localizedStringWithFormat("%02dh:%02dm:%02ds", hsTimeToEnd.hour, hsTimeToEnd.minute, hsTimeToEnd.second)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector: Selector("subtractTime"), userInfo:nil, repeats: true)
    }
    
    func subtractTime() {
        let hsTimeToEnd = hsCalendar.timeToEnd(NSDate())
        let hsDaysToEnd = hsCalendar.daysToEnd(NSDate())
        
        // set the countdown
        daysToEnd.text = "\(hsDaysToEnd) Days"
        timeToEnd.text = String.localizedStringWithFormat("%02dh:%02dm:%02ds", hsTimeToEnd.hour, hsTimeToEnd.minute, hsTimeToEnd.second)
        
        if (hsDaysToEnd == 0 && hsTimeToEnd.hour == 0 && hsTimeToEnd.minute == 0 && hsTimeToEnd.second == 0) {
            timer.invalidate()
            
            let alert = UIAlertController(title: "The end is here!",
                message: "Congratuations! This is the end you were hoping for",
                preferredStyle: UIAlertControllerStyle.Alert)
            //alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {action in
            //self.setupGame()}))
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }

}

