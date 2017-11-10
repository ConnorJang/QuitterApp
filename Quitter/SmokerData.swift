//
//  SmokerData.swift
//  Quitter
//
//  Created by Connor Jang on 2017-11-10.
//  Copyright © 2017 iMac03. All rights reserved.
//

import UIKit
import os.log

class SmokerData: NSObject, NSCoding {
    
    
    
    // Types
    struct PropertyKey {
        static let smokesPerDay = "smokesPerDay"
        static let smokesPerPack = "smokesPerPack"
        static let costPerPack = "costPerPack"
        static let yearsSmoking = "yearsSmoking"
    }

    
    // Properties, corresponding with input fields at launch
    var smokesPerDay: Double
    var smokesPerPack: Double
    var costPerPack: Double
    var yearsSmoking: Double
    
    // Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("smokerData") // SmokerData.ArchiveURL.path
    
    
    // Initialization
    init?(smokesPerDay: Double, smokesPerPack: Double, costPerPack: Double, yearsSmoking: Double)
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
    }
    
    
    // NSCoding
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(smokesPerDay, forKey: PropertyKey.smokesPerDay)
        aCoder.encode(smokesPerPack, forKey: PropertyKey.smokesPerPack)
        aCoder.encode(costPerPack, forKey: PropertyKey.costPerPack)
        aCoder.encode(yearsSmoking, forKey: PropertyKey.yearsSmoking)
    }
    
    // Required - means this initializer must be implemented on every subclass
    // Convenience - modifier means that this is a secondary initializer, and that it must call a designated initializer from the same class.
    // ? - Failable initializer
    required convenience init?(coder aDecoder: NSCoder)
    {
        // The smokesPerDay is required. If we cannot decode an Double, the initializer should fail.
        guard let smokesPerDay = aDecoder.decodeObject(forKey: PropertyKey.smokesPerDay) as? Double else {
            os_log("Unable to decode the smokesPerDay for a SmokerData object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The smokesPerPack is required. If we cannot decode an Double, the initializer should fail.
        guard let smokesPerPack = aDecoder.decodeObject(forKey: PropertyKey.smokesPerPack) as? Double else {
            os_log("Unable to decode the smokesPerPack for a SmokerData object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The costPerPack is required. If we cannot decode an Double, the initializer should fail.
        guard let costPerPack = aDecoder.decodeObject(forKey: PropertyKey.costPerPack) as? Double else {
            os_log("Unable to decode the costPerPack for a SmokerData object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The smokesPerDay is required. If we cannot decode an Double, the initializer should fail.
        guard let yearsSmoking = aDecoder.decodeObject(forKey: PropertyKey.yearsSmoking) as? Double else {
            os_log("Unable to decode the yearsSmoking for a SmokerData object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(smokesPerDay: smokesPerDay, smokesPerPack: smokesPerPack, costPerPack: costPerPack, yearsSmoking: yearsSmoking)
    }
    
}


