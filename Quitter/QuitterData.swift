//
//  QuitterData.swift
//  Quitter
//
//  Created by Connor Jang on 2017-11-17.
//  Copyright © 2017 iMac03. All rights reserved.
//

import UIKit
import os.log
import Foundation

class QuitterData: NSObject, NSCoding {
    
    
    
    // Types
    struct PropertyKey {
        static let date = "date"
        static let cigsSmoked = "cigsSmoked"
    }
    
    
    // Properties, corresponding with input fields at launch
    var date: NSDate
    var cigsSmoked: Int

    
    // Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("smokerData") // SmokerData.ArchiveURL.path
    
    
    // Initialization
    init?(cigsSmoked : Int)
    {
        // Set date to current date when initilized
       self.date = NSDate()
        self.cigsSmoked = cigsSmoked
    }
    
    
    // NSCoding
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(cigsSmoked, forKey: PropertyKey.cigsSmoked)
    }
    
    // Required - means this initializer must be implemented on every subclass
    // Convenience - modifier means that this is a secondary initializer, and that it must call a designated initializer from the same class.
    // ? - Failable initializer
    required convenience init?(coder aDecoder: NSCoder)
    {
        // The cigsSmoked is required. If we cannot decode an Double, the initializer should fail.
        guard let cigsSmoked = aDecoder.decodeObject(forKey: PropertyKey.cigsSmoked) as? Int else {
            os_log("Unable to decode the cigsSmoked for a QuitterData object.", log: OSLog.default, type: .debug)
            return nil
        }
        // Must call designated initializer.
        self.init(cigsSmoked : cigsSmoked)
    }
    
    
    func getDateFormatted(format : String) -> String
    {
        var dateString : String
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current // Set to current locale (implicitly set, but here's the explicit way)
        
        switch format
        {
        case "long":
            dateFormatter.dateStyle = DateFormatter.Style.long
            dateString = dateFormatter.string(from: date as Date)
            return dateString
        
        case "medium":
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateString = dateFormatter.string(from: date as Date)
            return dateString
            
        case "short":
            dateFormatter.dateStyle = DateFormatter.Style.short
            dateString = dateFormatter.string(from: date as Date)
            return dateString
        
        default:
            dateString = "Invalid date style..."
            return dateString
        }
    }
}


