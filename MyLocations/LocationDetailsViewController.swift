//
//  LocationDetailsViewController.swift
//  MyLocations
//
//  Created by Tyler Moore on 11/10/20.
//

import Foundation
import UIKit
import CoreLocation

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

class LocationDetailToCategoryPickerSegue: UIStoryboardSegue {}

class LocationDetailsViewController: UITableViewController {
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var placemark: CLPlacemark?
    var category = LocationCategory.noCategory
    
    // MARK:- Actions
    @IBAction func done() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func categoryPickerDidPickCategory(_ segue: UIStoryboardSegue) {
        if let controller = segue.source as? CategoryPickerViewController {
            category = controller.selectedCategory
            categoryLabel.text = category.rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.text = ""
        categoryLabel.text = category.rawValue
        
        latitudeLabel.text = String(format: "%.8f", coordinate.latitude)
        longitudeLabel.text = String(format: "%.8f", coordinate.longitude)
        if let placemark = placemark {
            addressLabel.text = placemark.toString(includeCountry: true, separateLines: false)
        } else {
            addressLabel.text = "No Address Found"
        }
        
        dateLabel.text = format(date: Date())
    }
}

// MARK:- Helpers
extension LocationDetailsViewController {
    func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}

// MARK:- Navigation
extension LocationDetailsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue is LocationDetailToCategoryPickerSegue {
            if let controller = segue.destination as? CategoryPickerViewController {
                controller.selectedCategory = category
            }
        }
    }
}
