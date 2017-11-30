//
//  SmokerTabViewController.swift
//  Quitter
//
//  Created by iMac03 on 2017-11-29.
//  Copyright © 2017 iMac03. All rights reserved.
//

import UIKit

class SmokerTabViewController: UIViewController {

    var cashBurned = 0.0
    var cigsSmoked = 0
    var lifeLostMins = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let data : [SmokerData] = loadSmokerData()!
        
        print("---------------------- Smoker Stats ------------------------")
        print("---> Time as a smoker: \(data[0].yearsSmoking) years")
        // Do any additional setup after loading the view.
        cashBurned = (data[0].smokesPerDay/data[0].smokesPerPack) * (data[0].yearsSmoking * 365) * data[0].costPerPack
        print("---> Cash burned: $\(cashBurned)")
        
        cigsSmoked = Int((data[0].smokesPerDay) * (data[0].yearsSmoking * 365))
        print("---> Cigarettes Smoked: \(cigsSmoked)")
        
        lifeLostMins = cigsSmoked * 11
        let lostDays = lifeLostMins / 60 / 24
        let lostHours  = ((lifeLostMins / 60) % 24)
        let lostMins = lifeLostMins % 60
        print("---> Life Lost : \(lostDays) days, \(lostHours) hrs, \(lostMins) mins")
        
        print("============= ^^Smoker Tab^^ =============")
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

