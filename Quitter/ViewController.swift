//
//  ViewController.swift
//  Quitter
//
//  Created by iMac03 on 2017-10-17.
//  Copyright © 2017 iMac03. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController {
    
    var smokerData: SmokerData? = SmokerData(smokesPerDay: 0, smokesPerPack: 0, costPerPack: 0, yearsSmoking: 0, date: NSDate())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setup the Steppers
        smokesPerDayStepper.value = Double(smokesPerDayField.text!)!
        smokesPerPackStepper.value = Double(smokesPerPackField.text!)!
        // Removing '$' from cost value
        var costString:String = costPerPackField.text!
        costString.remove(at: costString.startIndex)
        yearsSmokingStepper.value = Double(yearsSmokingField.text!)!

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let data = loadSmokerData()
        if data != nil {
            print("should be going to tabs view now...")
            performSegue(withIdentifier: "goToTabs", sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Connecting the textfields from first-time launch screen
    @IBOutlet weak var smokesPerDayField: UITextField!
    @IBOutlet weak var smokesPerPackField: UITextField!
    @IBOutlet weak var costPerPackField: UITextField!
    @IBOutlet weak var yearsSmokingField: UITextField!
    // Connect the steppers from first-time launch screen
    @IBOutlet weak var smokesPerDayStepper: UIStepper!
    @IBOutlet weak var smokesPerPackStepper: UIStepper!
    @IBOutlet weak var yearsSmokingStepper: UIStepper!
    
    
    // Values changed in the textfield, setting stepper to the new value
    @IBAction func smokesPerDayChanged(_ sender: UITextField) {
        smokesPerDayStepper.value = Double(smokesPerDayField.text!)!
        print("smokesperdaychanged \(smokesPerDayStepper.value)")
    }
    @IBAction func smokesPerPackChanged(_ sender: UITextField) {
        smokesPerPackStepper.value = Double(smokesPerPackField.text!)!
    }
    @IBAction func yearsSmokingChanged(_ sender: UITextField) {
        yearsSmokingStepper.value = Double(yearsSmokingField.text!)!
        smokerData?.yearsSmoking = yearsSmokingStepper.value
    }
    
    
    // Stepper actions - incrementing/decrementing the textfields
    @IBAction func smokesPerDayAction(_ sender: UIStepper) {
        smokesPerDayField.text = Int(sender.value).description
        smokerData?.smokesPerDay = smokesPerDayStepper.value
    }
    @IBAction func smokesPerPackAction(_ sender: UIStepper) {
        smokesPerPackField.text = Int(sender.value).description
    }

    @IBAction func yearsSmokingAction(_ sender: UIStepper) {
        yearsSmokingField.text = Int(sender.value).description
        smokerData?.yearsSmoking = yearsSmokingStepper.value

    }
    
    @IBAction func letsStartAction(_ sender: UIButton) {
        saveSmokerData()
//        print("SmokersPerDay = \(smokerData?.smokesPerDay ?? -1)")
//        print("smokesPerPack = \(smokerData?.smokesPerPack ?? -1)")
//        print("costPerPack = $\(smokerData?.costPerPack ?? -1)")
//        print("yearsSmoking = \(smokerData?.yearsSmoking ?? -1)")
        performSegue(withIdentifier: "goToTabs", sender: sender)
    }
    // Saving the data entered by the user
    private func saveSmokerData() {
        // Grab the data from the input boxes, then save the 0bject
        smokerData?.smokesPerDay = Double(smokesPerDayField.text!)!
        smokerData?.smokesPerPack = Double(smokesPerPackField.text!)!
        smokerData?.yearsSmoking = Double(yearsSmokingField.text!)!
        // Removing '$' from cost value
        var costString:String = costPerPackField.text!
        costString.remove(at: costString.startIndex)
        smokerData?.costPerPack = Double(costString)!
        
        var savedArray = [SmokerData]()
        savedArray.append(smokerData!)
        
        
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(savedArray as Any, toFile: SmokerData.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Data successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save Data...", log: OSLog.default, type: .error)
        }
        smokerData?.printSmokerData()
    }
    
    // For loading the data
    public func loadSmokerData() -> [SmokerData]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: SmokerData.ArchiveURL.path) as? [SmokerData]
    }
    
    

}

