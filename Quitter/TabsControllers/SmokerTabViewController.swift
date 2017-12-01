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
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cigsLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let data : [SmokerData] = loadSmokerData()!
        
        print("---------------------- Smoker Stats ------------------------")
        let secondsSmoking = Int(data[0].yearsSmoking * 365.0 * 24 * 60 * 60)
        print("---> Time as a smoker: \(secondsToTime(seconds: secondsSmoking))")
        timeLabel.text = "Time as a smoker: \n\(secondsToTime(seconds: secondsSmoking))"
        
        // Do any additional setup after loading the view.
        cashBurned = (data[0].smokesPerDay/data[0].smokesPerPack) * (data[0].yearsSmoking * 365) * data[0].costPerPack
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        var cashString = ""
        cashString += formatter.string(from: cashBurned as NSNumber)!
        print("---> Cash burned: \(cashString)")
        moneyLabel.text = "Cash burned: \n\(cashString)"
        
        cigsSmoked = Int(data[0].smokesPerDay * (data[0].yearsSmoking * 365.0))
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        var cigsString = ""
        cigsString += numberFormatter.string(from: cigsSmoked as NSNumber)!
        print("---> Cigarettes Smoked: \(cigsString)")
        cigsLabel.text = "Cigarettes Smoked: \n\(cigsString)"
        
        let lostSecs = cigsSmoked * 11 * 60
        print("---> Life Lost : \(secondsToTime(seconds: lostSecs))")
        lifeLabel.text = "Lifetime Lost from Smoking: \n\(secondsToTime(seconds: lostSecs))"
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
        
        if days < 365 {
            return "\(days) days, \(hours) hours, \(mins) mins"
        } else {
            let years = days / 365
            let daysRemainder = days % 365
            return "\(years) years, \(daysRemainder) days, \(hours) hours, \(mins) mins"
        }
        
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

