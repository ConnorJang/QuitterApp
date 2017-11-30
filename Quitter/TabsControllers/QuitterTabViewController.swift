//
//  QuitterTabViewController.swift
//  Quitter
//
//  Created by iMac03 on 2017-11-29.
//  Copyright © 2017 iMac03. All rights reserved.
//

import UIKit
import Foundation

class QuitterTabViewController: UIViewController {

    var cashBurned = 0.0
    var cigsSmoked = 0
    var lifeLostMins = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let data : [SmokerData] = loadSmokerData()!

        print("---------------------- Quitter Stats ------------------------")
        
        let secsSinceQuit : Int = data[0].timeSinceQuit()
        let daysSince = secsSinceQuit / 86400
        
        print("---> Time since quit: \(secondsToTime(seconds: secsSinceQuit))")
        //print("---> Time since quit: \(daysSince) days, \(hoursSinceRemainder) hours, \(minsSinceRemainder) mins, \(remainder) seconds")
        
        let cigsResisted = daysSince * Int(data[0].smokesPerDay)
        print("---> Cigs Resisted: \(cigsResisted)")
        
        let cashSaved = Double(10) * (data[0].smokesPerDay/data[0].smokesPerPack) * data[0].costPerPack
        let cashSavedString = String(format: "%.2f", cashSaved)
        print("---> Cash Saved: $\(cashSavedString)")
        
        let lifeTimeSaved = daysSince * 11
        let lifeSavedDays = lifeTimeSaved / 60 / 24
        let savedHours  = ((lifeTimeSaved / 60) % 24)
        let savedMins = lifeTimeSaved % 60
        print("---> Lifetime Saved: \(lifeSavedDays) days, \(savedHours) hrs, \(savedMins) mins")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // For loading the data
    public func loadSmokerData() -> [SmokerData]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: SmokerData.ArchiveURL.path) as? [SmokerData]
    }
    
    func secondsToTime(seconds: Int) -> String
    {
        //let secsSinceQuit : Int = data[0].timeSinceQuit()
        let days = seconds / 86400
        var remainder = seconds % 86400 // remainder from secs in a day
        
        let hours = remainder / 3600
        remainder = remainder % 3600 // update remainder
        let mins = remainder / 60
        remainder = remainder % 60
        
        //print("---> Total Seconds since quit: \(secsSinceQuit)")
        return "\(days) days, \(hours) hours, \(mins) mins"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
