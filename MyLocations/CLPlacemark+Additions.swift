//
//  CLPlacemark+Additions.swift
//  MyLocations
//
//  Created by Tyler Moore on 11/6/20.
//

import Foundation
import CoreLocation

extension CLPlacemark {
    func toString(includeCountry: Bool = false, separateLines: Bool = true) -> String {
        var line1 = ""
        if let subThoroughfare = subThoroughfare {
            line1 += subThoroughfare + " "
        }
        if let thoroughfare = thoroughfare {
            line1 += thoroughfare
        }
        
        var line2 = ""
        if let locality = locality {
            line2 += locality + " "
        }
        if let administrativeArea = administrativeArea {
            line2 += administrativeArea + ", "
        }
        if let postalCode = postalCode {
            line2 += postalCode
        }
        if includeCountry, let country = country {
            line2 += " " + country
        }
        
        let separator = separateLines ? "\n" : " "
        return line1 + separator + line2
    }
    
    /**
     Format a CLPlacemark's address string according to an input format string.
     Trims leading and trailing whitespace on the result
     Values (as vars in CLPlacemark):
     - %n - subThoroughfare
     - %s - thoroughfare
     - %l - locality
     - %a - administrativeArea
     - %p - postalCode
     - %c - country
     
     - Parameter format: the string describing the format of the output string
     */
    func toString(format: String) -> String {
        let formatDict = [
            "%n": subThoroughfare,
            "%s": thoroughfare,
            "%l": locality,
            "%a": administrativeArea,
            "%p": postalCode,
            "%c": country,
        ]
        var output = format
        formatDict.forEach() {key, value in
            if let value = value {
                output = output.replacingOccurrences(of: key, with: value)
            } else {
                output = output.replacingOccurrences(of: key, with: "")
            }
        }
        return output.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
