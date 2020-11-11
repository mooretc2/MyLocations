//
//  CLPlacemark+Additions.swift
//  MyLocations
//
//  Created by Tyler Moore on 11/6/20.
//

import Foundation
import CoreLocation

extension CLPlacemark {
    func toString(includeCountry: Bool = false, separateLines: Bool = true) -> String{
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
}
