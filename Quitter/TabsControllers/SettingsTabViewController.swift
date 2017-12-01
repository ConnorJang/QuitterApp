//
//  SettingsTabViewController.swift
//  Quitter
//
//  Created by iMac03 on 2017-11-30.
//  Copyright © 2017 iMac03. All rights reserved.
//

import UIKit
import os.log

class SettingsTabViewController: UIViewController {

    var data : [SmokerData] = []
    // Input fields
    @IBOutlet weak var smokesPerDayLabel: UITextField!
    @IBOutlet weak var smokesPerPackLabel: UITextField!
    @IBOutlet weak var costPerPackLabel: UITextField!
    @IBOutlet weak var yearsSmokingLabel: UITextField!
    // Steppers
    @IBOutlet weak var perDayStepper: UIStepper!
    @IBOutlet weak var yearsSmokingStepper: UIStepper!
    @IBOutlet weak var perPackStepper: UIStepper!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.costPerPackLabel.keyboardType = UIKeyboardType.decimalPad

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        data = loadSmokerData()!
        data[0].printSmokerData()
        
        smokesPerDayLabel.text = "\(Int(data[0].smokesPerDay))"
        smokesPerPackLabel.text = "\(Int(data[0].smokesPerPack))"
        
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        var costString = ""
        costString += numberFormatter.string(from: data[0].costPerPack as NSNumber)!
        costPerPackLabel.text = "\(costString)"
        
        yearsSmokingLabel.text = "\(data[0].yearsSmoking)"
        
        // Setup the Steppers
        perDayStepper.value = Double(smokesPerDayLabel.text!)!
        perPackStepper.value = Double(smokesPerPackLabel.text!)!
        yearsSmokingStepper.value = Double(yearsSmokingLabel.text!)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // For loading the data
    public func loadSmokerData() -> [SmokerData]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: SmokerData.ArchiveURL.path) as? [SmokerData]
    }
    
    // Saving the data entered by the user
    private func saveSmokerData(smokerData : [SmokerData]) {
        // Grab the data from the input boxes, then save the 0bject
        smokerData[0].smokesPerDay = Double(smokesPerDayLabel.text!)!
        smokerData[0].smokesPerPack = Double(smokesPerPackLabel.text!)!
        smokerData[0].costPerPack = Double(costPerPackLabel.text!)!
        smokerData[0].yearsSmoking = Double(yearsSmokingLabel.text!)!
        

 
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(smokerData as Any, toFile: SmokerData.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Data successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save Data...", log: OSLog.default, type: .error)
        }
        smokerData[0].printSmokerData()
    }

    @IBAction func saveButtonAction(_ sender: UIButton) {
        saveSmokerData(smokerData: data)
        
    }
    
    @IBAction func yearsStepperAction(_ sender: UIStepper) {
       yearsSmokingLabel.text = Double(sender.value).description
        
    }

    @IBAction func perPackStepperAction(_ sender: UIStepper) {
        smokesPerPackLabel.text = Int(sender.value).description
    }
    
    @IBAction func perDayStepperAction(_ sender: UIStepper) {
        smokesPerDayLabel.text = Int(sender.value).description

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
