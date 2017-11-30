//
//  SmokerData.swift
//  Quitter
//
//  Created by Connor Jang on 2017-11-10.
//  Copyright © 2017 iMac03. All rights reserved.
//

import UIKit
import os.log
import Foundation

class SmokerData: NSObject, NSCoding {
    
    
    
    // Types
    struct PropertyKey {
        static let smokesPerDay = "smokesPerDay"
        static let smokesPerPack = "smokesPerPack"
        static let costPerPack = "costPerPack"
        static let yearsSmoking = "yearsSmoking"
        static let date = "date"
    }

    
    // Properties, corresponding with input fields at launch
    var smokesPerDay: Double
    var smokesPerPack: Double
    var costPerPack: Double
    var yearsSmoking: Double
    var date : NSDate
    
    // Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("smokerData") // SmokerData.ArchiveURL.path
    
    
    // Initialization
    init?(smokesPerDay: Double, smokesPerPack: Double, costPerPack: Double, yearsSmoking: Double, date: NSDate)
    {
        // Initialization should fail if there is no name or if the rating is negative.
        if smokesPerPack < 0 || smokesPerPack < 0 || costPerPack < 0.0 || yearsSmoking < 0.0
        {
            return nil
        }
        
        self.smokesPerDay = smokesPerDay
        self.smokesPerPack = smokesPerPack
        self.costPerPack = costPerPack
        self.yearsSmoking = yearsSmoking
        self.date = date
    }
    
    
    // NSCoding
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(smokesPerDay, forKey: PropertyKey.smokesPerDay)
        aCoder.encode(smokesPerPack, forKey: PropertyKey.smokesPerPack)
        aCoder.encode(costPerPack, forKey: PropertyKey.costPerPack)
        aCoder.encode(yearsSmoking, forKey: PropertyKey.yearsSmoking)
        aCoder.encode(date, forKey: PropertyKey.date)
    }
    
    // Required - means this initializer must be implemented on every subclass
    // Convenience - modifier means that this is a secondary initializer, and that it must call a designated initializer from the same class.
    // ? - Failable initializer
    required convenience init?(coder aDecoder: NSCoder)
    {
        // The smokesPerDay is required. If we cannot decode an Double, the initializer should fail.
        let smokesPerDay = aDecoder.decodeDouble(forKey: PropertyKey.smokesPerDay)
        // The smokesPerPack is required. If we cannot decode an Double, the initializer should fail.
        let smokesPerPack = aDecoder.decodeDouble(forKey: PropertyKey.smokesPerPack)
        // The costPerPack is required. If we cannot decode an Double, the initializer should fail.
        let costPerPack = aDecoder.decodeDouble(forKey: PropertyKey.costPerPack)
        // The smokesPerDay is required. If we cannot decode an Double, the initializer should fail.
        let yearsSmoking = aDecoder.decodeDouble(forKey: PropertyKey.yearsSmoking)
        let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? NSDate
        // Must call designated initializer.
        self.init(smokesPerDay: smokesPerDay, smokesPerPack: smokesPerPack, costPerPack: costPerPack, yearsSmoking: yearsSmoking, date: date!)
    }
    
    func timeSinceQuit() -> Int
    {
        let today = NSDate()
        let timeSince = today.timeIntervalSince(date as Date)
        //let timeSince70 = today.timeIntervalSince1970
        //print("----> Date: \(date) --- Today: \(today)")
        //print("---> Time since1970: \(timeSince70)")
        return Int(timeSince)
    }
    
    func printSmokerData()
    {
        print("Smokes Per day: \(smokesPerDay) \nSmokes Per Pack \(smokesPerPack) \nCost Per Pack \(costPerPack) \nYears Smoking: \(yearsSmoking) \nDate: \(date)")
    }
    
}


