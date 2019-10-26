//
//  CityWeatherViewController.swift
//  weatherapp
//
//  Created by Ville-Veikko Nieminen on 07/10/2019.
//  Copyright © 2019 Ville-Veikko Nieminen. All rights reserved.
//

import UIKit

class CityWeatherViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var cityText: UITextField!
    private let cityDataSource = CityDataSource()
    var locationHelper : LocationHelper?

    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.delegate = self
        cityTableView.dataSource = self.cityDataSource
    }
    
    @IBAction func ButtonClicked(_ sender: Any) {
        var button: UIButton = sender as! UIButton
        
        if button.titleLabel?.text == "Add" {
            cityDataSource.cities.append(cityText.text!)
            print(cityDataSource.cities)
            cityTableView.reloadData()

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selected = cityDataSource.cities[indexPath.row]
        
        if selected == "Use GPS" {
            UserDefaults.standard.set(nil, forKey: "city")
            locationHelper!.location == nil
            tabBarController?.selectedIndex = 0
        } else {
            UserDefaults.standard.set(selected, forKey: "city")
        }
    }
    
}

