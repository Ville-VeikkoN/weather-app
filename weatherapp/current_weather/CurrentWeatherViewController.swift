//
//  CurrentWeatherViewController.swift
//  weatherapp
//
//  Created by Ville-Veikko Nieminen on 07/10/2019.
//  Copyright © 2019 Ville-Veikko Nieminen. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: UIViewController {
    
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    let httpHelper = HttpHelper()
    
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    var locationHelper : LocationHelper?
    var timer : Timer?
    var apiKey = "f3273a63a43d6b9d47efcb881cb64dca"
    let baseURLPath = "https://api.openweathermap.org/data/2.5/weather?q="
    let baseImgUrl = "https://openweathermap.org/img/wn/"
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showSpinner(onView: view)
        updateLoc()
    }
    
    func updateLoc() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc
    func update() {
        if let location = locationHelper?.location {
            cityLabel.text = locationHelper?.locality
            stopUpdatingLoc()
        }
    }
    
    func stopUpdatingLoc() {
        timer?.invalidate()
        UserDefaults.standard.setValue(locationHelper!.locality!, forKey: "city")
        httpHelper.fetchUrl(url: "\(baseURLPath)\(locationHelper!.locality!)&units=metric&APPID=\(apiKey)", completionHandler: self.doneFetching) // &APPID=\(apiKey)
    }
    
    
    func setImage(data: Data!) {
        self.weatherIcon.image = UIImage(data: data)
    }

    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
        self.removeSpinner()
        
        let resstr = String(data: (data!), encoding: String.Encoding.utf8)

        DispatchQueue.main.async(execute: {() in
            let decoder = JSONDecoder()
            do{
                let currentWeather = try decoder.decode(CurrentWeatherData.self, from: data!)
                //   NSLog(currentWeather.coord)
                self.degreeLabel.text = "\(currentWeather.main.temp) °C"
                self.httpHelper.downloadImage(fromUrl: URL(string: "\(self.baseImgUrl)\(currentWeather.weather.first!.icon)@2x.png")!, completionHandler: self.setImage)
            } catch {
                print(error)
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.degreeLabel.text = ""
        self.weatherIcon.image = nil
        
        if let city = UserDefaults.standard.string(forKey: "city") {
            httpHelper.fetchUrl(url: "\(baseURLPath)\(city)&units=metric&APPID=\(apiKey)", completionHandler: self.doneFetching)
            cityLabel.text = city
        } else {
            self.showSpinner(onView: view)
            updateLoc()
        }
    }
    
}

