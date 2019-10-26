//
//  HttpHelper.swift
//  weatherapp
//
//  Created by Ville-Veikko Nieminen on 22/10/2019.
//  Copyright © 2019 Ville-Veikko Nieminen. All rights reserved.
//

import Foundation

class HttpHelper {
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(fromUrl: URL, completionHandler: @escaping (Data) -> Void) {
        getData(from: fromUrl) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                completionHandler(data)
                
            }
        }
        
    }
    
    
    func fetchUrl(url : String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        var tempUrl = url.replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: "ä", with: "a")
            .replacingOccurrences(of: "ö", with: "o")
        
        let url : URL? = URL(string: tempUrl)
        
        let task = session.dataTask(with: url!, completionHandler: completionHandler);
        
        task.resume();
    }
}
