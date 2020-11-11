//
//  CategoryPickerViewController.swift
//  MyLocations
//
//  Created by Tyler Moore on 11/10/20.
//

import Foundation
import UIKit

enum LocationCategory: String, CaseIterable, Codable {
    case noCategory = "No Category"
    case appleStore = "Apple Store"
    case bar = "Bar"
    case bookstore = "Bookstore"
    case club = "Club"
    case groceryStore = "Grocery Store"
    case historicBuilding = "Historic Building"
    case house = "House"
    case iceCreamVendor = "Ice Cream Vendor"
    case landmark = "Landmark"
    case park = "Park"
    
    var index: Int? {
        LocationCategory.allCases.firstIndex(of: self)
    }
}

class CategoryPickerToLocationDetailSegue: UIStoryboardSegue {}

class CategoryPickerViewController: UITableViewController {
    var selectedCategory = LocationCategory.noCategory
    
    var selectedIndexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index = selectedCategory.index {
            selectedIndexPath = IndexPath(row: index, section: 0)
        }
    }
}

// MARK:- Table View Delegates
extension CategoryPickerViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocationCategory.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let category = LocationCategory.allCases[indexPath.row]
        cell.textLabel!.text = category.rawValue
        
        if category == selectedCategory {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != selectedIndexPath.row {
            if let newCell = tableView.cellForRow(at: indexPath) {
                newCell.accessoryType = .checkmark
            }
            if let oldCell = tableView.cellForRow(at: selectedIndexPath) {
                oldCell.accessoryType = .none
            }
            selectedIndexPath = indexPath
        }
    }
}

// MARK :- Navigation
extension CategoryPickerViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue is CategoryPickerToLocationDetailSegue, let cell = sender as? UITableViewCell {
            if let indexPath = tableView.indexPath(for: cell) {
                selectedCategory = LocationCategory.allCases[indexPath.row]
            }
        }
    }
}
