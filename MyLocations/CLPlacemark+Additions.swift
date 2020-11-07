//
//  CLPlacemark+Additions.swift
//  MyLocations
//
//  Created by Tyler Moore on 11/6/20.
//

import Foundation
import CoreLocation

extension CLPlacemark {
    func toString() -> String{
        var line1 = ""
        if let tmp = subThoroughfare {
            line1 += tmp + " "
        }
        if let tmp = thoroughfare {
            line1 += tmp
        }
        
        var line2 = ""
        if let tmp = locality {
            line2 += tmp + " "
        }
        if let tmp = administrativeArea {
            line2 += tmp + " "
        }
        if let tmp = postalCode {
            line2 += tmp
        }
        
        return line1 + "\n" + line2
    }
}
