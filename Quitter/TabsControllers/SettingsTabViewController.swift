//
//  SettingsTabViewController.swift
//  Quitter
//
//  Created by iMac03 on 2017-11-30.
//  Copyright © 2017 iMac03. All rights reserved.
//

import UIKit

class SettingsTabViewController: UIViewController {

    // Input fields
    @IBOutlet weak var smokesPerDayLabel: UITextField!
    @IBOutlet weak var smokesPerPackLabel: UITextField!
    @IBOutlet weak var costPerPackLabel: UITextField!
    @IBOutlet weak var yearsSmokingLabel: UITextField!
    // Steppers
    @IBOutlet weak var perDayStepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.costPerPackLabel.keyboardType = UIKeyboardType.decimalPad

        // Do any additional setup after loading the view.
        var data : [SmokerData] = loadSmokerData()!
        data[0].printSmokerData()
        
        smokesPerDayLabel.text = "\(Int(data[0].smokesPerDay))"
        smokesPerPackLabel.text = "\(Int(data[0].smokesPerPack))"
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        var costString = ""
        costString += numberFormatter.string(from: data[0].costPerPack as NSNumber)!
        costPerPackLabel.text = "\(costString)"
        
        yearsSmokingLabel.text = "\(data[0].yearsSmoking)"
        
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
