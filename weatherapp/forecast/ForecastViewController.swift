//
//  ForecastViewController.swift
//  weatherapp
//
//  Created by Ville-Veikko Nieminen on 07/10/2019.
//  Copyright © 2019 Ville-Veikko Nieminen. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController, UITableViewDelegate {
    
    private let dataSource = DataSource()
    private let httpHelper = HttpHelper()
    var locationHelper : LocationHelper?
    @IBOutlet weak var forecastTableView: UITableView!
    var apiKey = "f3273a63a43d6b9d47efcb881cb64dca"
    let baseURLPath = "https://api.openweathermap.org/data/2.5/forecast?q="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastTableView.delegate = self
        if let city = UserDefaults.standard.string(forKey: "city") {
            httpHelper.fetchUrl(url: "\(baseURLPath)\(city)&units=metric&APPID=\(apiKey)", completionHandler: self.doneFetching)
        }
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {

        let resstr = String(data: (data!), encoding: String.Encoding.utf8)
        
        DispatchQueue.main.async(execute: {() in
            let decoder = JSONDecoder()
            do{
                let forecast = try decoder.decode(ForecastData.self, from: data!)
                self.dataSource.forecasts = forecast.list
                self.forecastTableView.dataSource = self.dataSource
                self.forecastTableView.reloadData()
            } catch {
                print(error)
            }
        })

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let city = UserDefaults.standard.string(forKey: "city") {
            httpHelper.fetchUrl(url: "\(baseURLPath)\(city)&units=metric&APPID=\(apiKey)", completionHandler: self.doneFetching)
        }
    }
    
    
}

