//
//  ViewController.swift
//  Quitter
//
//  Created by iMac03 on 2017-10-17.
//  Copyright © 2017 iMac03. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setup the Steppers
        smokesPerDayStepper.value = Double(smokesPerDayField.text!)!
        smokesPerPackStepper.value = Double(smokesPerPackField.text!)!
        //costPerPackStepper.value = Double(costPerPackField.text!)!
        yearsSmokingStepper.value = Double(yearsSmokingField.text!)!
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
    @IBOutlet weak var costPerPackStepper: UIStepper!
    @IBOutlet weak var yearsSmokingStepper: UIStepper!
    
    
    // Values changed in the textfield, setting stepper to the new value
    @IBAction func smokesPerDayChanged(_ sender: UITextField) {
        smokesPerDayStepper.value = Double(smokesPerDayField.text!)!
    }
    @IBAction func smokesPerPackChanged(_ sender: UITextField) {
        smokesPerPackStepper.value = Double(smokesPerPackField.text!)!
    }
    @IBAction func yearsSmokingChanged(_ sender: UITextField) {
        yearsSmokingStepper.value = Double(yearsSmokingField.text!)!
    }
    
    
    // Stepper actions - incrementing/decrementing the textfields
    @IBAction func smokesPerDayAction(_ sender: UIStepper) {
        smokesPerDayField.text = Int(sender.value).description
    }
    @IBAction func smokesPerPackAction(_ sender: UIStepper) {
        smokesPerPackField.text = Int(sender.value).description
    }
    @IBAction func costPerPackAction(_ sender: UIStepper) {
    }
    @IBAction func yearsSmokingAction(_ sender: UIStepper) {
        yearsSmokingField.text = Int(sender.value).description
    }
    
    
    

}

