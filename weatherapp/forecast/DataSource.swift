//
//  DataSource.swift
//  weatherapp
//
//  Created by Ville-Veikko Nieminen on 22/10/2019.
//  Copyright © 2019 Ville-Veikko Nieminen. All rights reserved.
//

import Foundation
import UIKit

class DataSource: NSObject, UITableViewDataSource {
    
    let httpHelper = HttpHelper()
    
    var forecasts = [List]()
        
    func setImage(data: Data!) {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")!
        let forecast = forecasts[indexPath.row]

        let weatherLabel : UILabel = cell.viewWithTag(1) as! UILabel
        let localDate = formatDate(dtTime: forecast.dt)
        weatherLabel.text = "\(forecast.main.temp) °C \(forecast.weather[0].description)"
        
        let timeLabel : UILabel = cell.viewWithTag(2)as! UILabel
        timeLabel.text = localDate
        
        httpHelper.downloadImage(fromUrl: URL(string: "https://openweathermap.org/img/wn/\(forecasts[indexPath.row].weather[0].icon).png")!, completionHandler: { (data) -> Void in
            cell.imageView?.image = UIImage(data: data)
        })
        
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
    
}
