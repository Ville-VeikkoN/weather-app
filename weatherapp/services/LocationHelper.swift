//
//  LocationHelper.swift
//  weatherapp
//
//  Created by Ville-Veikko Nieminen on 07/10/2019.
//  Copyright © 2019 Ville-Veikko Nieminen. All rights reserved.
//

import Foundation
import CoreLocation


class LocationHelper: NSObject, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager?
    var location : CLLocation?
    var geo : CLGeocoder?
    var latitude : Double?
    var longitude : Double?
    var locality : String?
    var locFound = false
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations[0]
        locationManager?.stopUpdatingLocation()
        updateGeoLoc()
    }
    
    func updateGeoLoc() {
        if geo == nil && location != nil {
            latitude = Double((location?.coordinate.latitude)! * 100).rounded() / 100
            longitude = Double((location?.coordinate.longitude)! * 100).rounded() / 100
            geo = CLGeocoder()
            geo!.reverseGeocodeLocation(location!, completionHandler: {(placemarks, error) in
                if(error != nil) {
                    print("Error: ",error!)
                }
                if((placemarks?.count)! > 0) {
                    let pm = placemarks![0] as CLPlacemark

                    self.locality = pm.locality!
                }
            })
            
        }
    }
}
