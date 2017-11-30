//
//  SmokerStatsViewController.swift
//  Quitter
//
//  Created by Connor Jang on 2017-10-20.
//  Copyright © 2017 iMac03. All rights reserved.
//

import UIKit
import Foundation

class SmokerStatsViewController: UIViewController {

    var cashBurned = 0.0
    var cigsSmoked = 0
    var lifeLostMins = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let data : [SmokerData] = loadSmokerData()!
        print("printing data inside Smoker Stats")
        for item in data {
            item.printSmokerData()
        }
        
        print("---------------------- Smoker Stats ------------------------")
        // Do any additional setup after loading the view.
        cashBurned = (data[0].smokesPerDay/data[0].smokesPerPack) * (data[0].yearsSmoking * 365) * data[0].costPerPack
        print("---> Cash burned: $\(cashBurned)")
        
        cigsSmoked = Int((data[0].smokesPerDay) * (data[0].yearsSmoking * 365))
        print("---> Cigarettes Cmoked: \(cigsSmoked)")
        
        lifeLostMins = cigsSmoked * 11
        let lifeLostDays = lifeLostMins / 60 / 24
        let lostHours  = ((lifeLostMins / 60) % 24)
        let lostMins = lifeLostMins % 60
//        print("---> Lost Hours (remainder): \(lostHours)")
//        print("---> Lost Mins (remainder): \(lostMins)")
//        print("---> Life lost (days): \(lifeLostDays)")
        print("---> Life Lost : \(lifeLostDays) days, \(lostHours) hrs, \(lostMins) mins")
        
        print("---------------------- Quitter Stats ------------------------")
        
        let secsSinceQuit : Int = data[0].timeSinceQuit()
        let daysSince = secsSinceQuit / 60 / 60 / 24
        var secsSinceRemainder = secsSinceQuit % 86400 // remainder from secs in a day
        
        let hoursSinceRemainder = secsSinceRemainder / 3600
        secsSinceRemainder = secsSinceRemainder % 3600
        let minsSinceRemainder = secsSinceQuit / 60
        secsSinceRemainder = secsSinceRemainder % 60
        
        print("---> Total Seconds since quit: \(secsSinceQuit)")
        print("---> Time since quit: \(daysSince) days, \(hoursSinceRemainder) hours, \(minsSinceRemainder) mins, \(secsSinceRemainder) seconds")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // For loading the data
    public func loadSmokerData() -> [SmokerData]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: SmokerData.ArchiveURL.path) as? [SmokerData]
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
