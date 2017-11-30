//
//  TotalTabViewController.swift
//  Quitter
//
//  Created by iMac03 on 2017-11-29.
//  Copyright © 2017 iMac03. All rights reserved.
//

import UIKit

class TotalTabViewController: UIViewController {

    var cashBurned = 0.0
    var cigsSmoked = 0
    var lifeLostMins = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let data : [SmokerData] = loadSmokerData()!

        let secsSinceQuit : Int = data[0].timeSinceQuit()
        let daysSince = secsSinceQuit / 86400
        let cigsResisted = daysSince * Int(data[0].smokesPerDay)
        let cashSaved = Double(10) * (data[0].smokesPerDay/data[0].smokesPerPack) * data[0].costPerPack

        
        print("---------------------- Comparison Stats ------------------------")
        
        // ------------------------ Percentage comparison ------------------------
        let smokerTimeSecs : Double = data[0].yearsSmoking * 365 * 24 * 60
        let percentUndone = Double(round(1000*(Double(secsSinceQuit) / smokerTimeSecs))/1000)// round 2 decimal places
        let percentString = String(format: "%.2f", percentUndone) // force 2 decimal places for x.xxx values
        print("---> Percent undone: \(percentString)%")
        
        // ------------------------ Cash comparison ------------------------
        let cashComparison = cashSaved - cashBurned
        //let cashString = String(format: "%.2f", )
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        var cashString = ""
        cashString += formatter.string(from: abs(cashComparison) as NSNumber)!
        
        if cashComparison >= 0 {
            print("---> Cash Comparison: \(cashString)")
        } else {
            print("---> Cash Comparison: -\(cashString)")
        }
        
        // ------------------------ Cigs Smoked comparison ------------------------
        let cigsComparison = cigsSmoked - cigsResisted
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        var cigsString = ""
        cigsString += numberFormatter.string(from: abs(cigsComparison) as NSNumber)!
        if cigsComparison >= 0 {
            print("---> Cigs Smoked Comparison: \(cigsString) cigs need to be resisted")
        } else {
            print("---> Cigs Smoked Comparison: \(cigsString) more cigs resisted than smoked!")
        }
        
        // ------------------------ Cigs Smoked comparison ------------------------
        let timeComparison = secsSinceQuit - Int(smokerTimeSecs)
        if timeComparison >= 0 {
            print("---> Time Comparison: \(secondsToTime(seconds: abs(timeComparison))) more time smoke-free!")
        } else {
            print("---> Time Comparison: \(secondsToTime(seconds: abs(timeComparison))) more time as a smoker")
        }
        
        print("============= ^^Total Tab^^ =============")
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

