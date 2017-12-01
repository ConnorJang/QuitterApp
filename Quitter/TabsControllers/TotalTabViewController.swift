//
//  TotalTabViewController.swift
//  Quitter
//
//  Created by iMac03 on 2017-11-29.
//  Copyright © 2017 iMac03. All rights reserved.
//

import UIKit

class TotalTabViewController: UIViewController {

    var lifeLostMins = 0
    
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var cigsLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let data : [SmokerData] = loadSmokerData()!
        
        let secsSinceQuit : Int = data[0].timeSinceQuit()
        let daysSince = Double(secsSinceQuit) / 60.0 / 60.0 / 24.0
        let cigsResisted = Int(daysSince * data[0].smokesPerDay)
        let cashSaved = daysSince * (data[0].smokesPerDay/data[0].smokesPerPack) * data[0].costPerPack
        let  cashBurned = (data[0].smokesPerDay/data[0].smokesPerPack) * (data[0].yearsSmoking * 365) * data[0].costPerPack
        print("---------------------- Comparison Stats ------------------------")
        
        
        
        // ------------------------ Cash comparison ------------------------
        let cashComparison = cashSaved - cashBurned
        //let cashString = String(format: "%.2f", )
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        var cashString = ""
        cashString += formatter.string(from: cashComparison as NSNumber)!
        
        print("---> Cash Comparison: \(cashString)")
        moneyLabel.text = "Cash Balance: \n\(cashString)"
        
        
        // ------------------------ Cigs Smoked comparison ------------------------
        let cigsSmoked = Int((data[0].smokesPerDay) * (data[0].yearsSmoking * 365))
        let cigsComparison = cigsSmoked - cigsResisted
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        var cigsString = ""
        cigsString += numberFormatter.string(from: abs(cigsComparison) as NSNumber)!
        print("---> Cigs Smoked Comparison: \(cigsString) more cigs smoked than resisted!")
        cigsLabel.text = "Cigs Smoked vs Resisted: \n\(cigsString)"
        
        // ------------------------ Percentage comparison ------------------------
        let percentUndone = Double(cigsResisted) / Double(cigsSmoked) * 100.0
        let percentString = String(format: "%.2f", percentUndone) // force 2 decimal places for x.xxx values
        print("---> Percent undone: \(percentString)%")
        percentLabel.text = "Percent Redeemed: \n\(percentString)%"
        
        // ------------------------ Life wasted vs reclaimed comparison ------------------------
        let timeComparison = cigsComparison * 11 * 60
        print("\(cigsComparison)")
        if timeComparison <= 0 {
            print("---> Time Comparison: You have undone all the damage!")
        } else {
            print("---> Time Comparison: \(secondsToTime(seconds: abs(timeComparison))) lost")
            lifeLabel.text = "Lifetime Left to be Recovered: \n\(secondsToTime(seconds: abs(timeComparison))) "
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

