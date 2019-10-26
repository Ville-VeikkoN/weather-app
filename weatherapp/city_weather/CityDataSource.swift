//
//  CityDataSource.swift
//  weatherapp
//
//  Created by Ville-Veikko Nieminen on 22/10/2019.
//  Copyright © 2019 Ville-Veikko Nieminen. All rights reserved.
//

import Foundation
import UIKit

class CityDataSource: NSObject, UITableViewDataSource {
        
    var cities = ["Use GPS", "Tampere", "Helsinki"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")!
        let city = cities[indexPath.row]
        
        cell.textLabel?.text = city
        
        return cell
    }
    
    func formatDate(dtTime: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(dtTime))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date as Date)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if cities[indexPath.row] == "Use GPS" {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.cities.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }

    }

    
}
