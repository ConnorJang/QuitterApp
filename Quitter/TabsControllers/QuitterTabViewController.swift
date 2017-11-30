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
    
    // Connecting labels
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cigsLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let data : [SmokerData] = loadSmokerData()!

        print("---------------------- Quitter Stats ------------------------")
        
        let secsSinceQuit : Int = data[0].timeSinceQuit()
        
        print("---> Time since quit: \(secondsToTime(seconds: secsSinceQuit))")
        timeLabel.text = "Time since quit: \n\(secondsToTime(seconds: secsSinceQuit))"
        
        let daysSince : Double = Double(data[0].timeSinceQuit()) / 60.0 / 60.0 / 24.0
        let cigsResisted = Int(daysSince * data[0].smokesPerDay)
        print("---> Cigs Resisted: \(cigsResisted)")
        cigsLabel.text = "Cigs Resisted: \n\(cigsResisted)"
        
        let cashSaved = Double(10) * (data[0].smokesPerDay/data[0].smokesPerPack) * data[0].costPerPack
        let cashSavedString = String(format: "%.2f", cashSaved)
        print("---> Cash Saved: $\(cashSavedString)")
        moneyLabel.text = "Cash Saved: \n$\(cashSavedString)"
        
        let minsSaved = daysSince * 11.0
        let secsSaved = minsSaved * 60
        
        print("---> Lifetime Saved: \(secondsToTime(seconds: Int(secsSaved)))")
        lifeLabel.text = "Lifetime Saved: \n\(secondsToTime(seconds: Int(secsSaved)))"
        
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
