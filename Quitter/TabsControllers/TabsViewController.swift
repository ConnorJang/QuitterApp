//
//  TabsViewController.swift
//  Quitter
//
//  Created by Connor Jang on 2017-11-24.
//  Copyright © 2017 iMac03. All rights reserved.
//

import UIKit

class TabsViewController: UITabBarController {
    
//    var cashBurned = 0.0
//    var cigsSmoked = 0
//    var lifeLostMins = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let data : [SmokerData] = loadSmokerData()!
//
//        print("---------------------- Smoker Stats ------------------------")
//        print("---> Time as a smoker: \(data[0].yearsSmoking) years")
//        // Do any additional setup after loading the view.
//        cashBurned = (data[0].smokesPerDay/data[0].smokesPerPack) * (data[0].yearsSmoking * 365) * data[0].costPerPack
//        print("---> Cash burned: $\(cashBurned)")
//
//        cigsSmoked = Int((data[0].smokesPerDay) * (data[0].yearsSmoking * 365))
//        print("---> Cigarettes Smoked: \(cigsSmoked)")
//
//        lifeLostMins = cigsSmoked * 11
//        let lostDays = lifeLostMins / 60 / 24
//        let lostHours  = ((lifeLostMins / 60) % 24)
//        let lostMins = lifeLostMins % 60
//        print("---> Life Lost : \(lostDays) days, \(lostHours) hrs, \(lostMins) mins")
//
//        print("---------------------- Quitter Stats ------------------------")
//
//        let secsSinceQuit : Int = data[0].timeSinceQuit()
//        let daysSince = secsSinceQuit / 86400
//
//        print("---> Time since quit: \(secondsToTime(seconds: secsSinceQuit))")
//        //print("---> Time since quit: \(daysSince) days, \(hoursSinceRemainder) hours, \(minsSinceRemainder) mins, \(remainder) seconds")
//
//        let cigsResisted = daysSince * Int(data[0].smokesPerDay)
//        print("---> Cigs Resisted: \(cigsResisted)")
//
//        let cashSaved = Double(10) * (data[0].smokesPerDay/data[0].smokesPerPack) * data[0].costPerPack
//        let cashSavedString = String(format: "%.2f", cashSaved)
//        print("---> Cash Saved: $\(cashSavedString)")
//
//        let lifeTimeSaved = daysSince * 11
//        let lifeSavedDays = lifeTimeSaved / 60 / 24
//        let savedHours  = ((lifeTimeSaved / 60) % 24)
//        let savedMins = lifeTimeSaved % 60
//        print("---> Lifetime Saved: \(lifeSavedDays) days, \(savedHours) hrs, \(savedMins) mins")
//
//        print("---------------------- Comparison Stats ------------------------")
//
//        // ------------------------ Percentage comparison ------------------------
//        let smokerTimeSecs : Double = data[0].yearsSmoking * 365 * 24 * 60
//        let percentUndone = Double(round(1000*(Double(secsSinceQuit) / smokerTimeSecs))/1000)// round 2 decimal places
//        let percentString = String(format: "%.2f", percentUndone) // force 2 decimal places for x.xxx values
//        print("---> Percent undone: \(percentString)%")
//
//        // ------------------------ Cash comparison ------------------------
//        let cashComparison = cashSaved - cashBurned
//        //let cashString = String(format: "%.2f", )
//        let formatter = NumberFormatter()
//        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
//        formatter.numberStyle = .currency
//        var cashString = ""
//        cashString += formatter.string(from: abs(cashComparison) as NSNumber)!
//
//        if cashComparison >= 0 {
//            print("---> Cash Comparison: \(cashString)")
//        } else {
//            print("---> Cash Comparison: -\(cashString)")
//        }
//
//        // ------------------------ Cigs Smoked comparison ------------------------
//        let cigsComparison = cigsSmoked - cigsResisted
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = NumberFormatter.Style.decimal
//        var cigsString = ""
//        cigsString += numberFormatter.string(from: abs(cigsComparison) as NSNumber)!
//        if cigsComparison >= 0 {
//            print("---> Cigs Smoked Comparison: \(cigsString) cigs need to be resisted")
//        } else {
//            print("---> Cigs Smoked Comparison: \(cigsString) more cigs resisted than smoked!")
//        }
//
//        // ------------------------ Cigs Smoked comparison ------------------------
//        let timeComparison = secsSinceQuit - Int(smokerTimeSecs)
//        if timeComparison >= 0 {
//            print("---> Time Comparison: \(secondsToTime(seconds: abs(timeComparison))) more time smoke-free!")
//        } else {
//            print("---> Time Comparison: \(secondsToTime(seconds: abs(timeComparison))) more time as a smoker")
//        }
//
//        print("============= ^^Total Tab^^ =============")
//
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        
        // Pass the selected object to the new view controller.
    }
    

}
