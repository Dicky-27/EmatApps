//
//  BaseRequest.swift
//  EmatApps
//
//  Created by Dicky Buwono on 06/08/21.
//

import Foundation

class BaseRequest: NSObject {
    
    static func GET(url: String,
                    showLoader: Bool,
                    completionHandler: @escaping (Any) -> Void) {
        
        if showLoader {
            //display loader
        }
        
        //init request
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        //configure request and set header
        request.httpMethod = "GET"
      //  request.allHTTPHeaderFields = header
        
        //init session
        let session = URLSession.shared
        
        //init datatask
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                if let dataFromAPI = data {
                    completionHandler(dataFromAPI)
                }
            }
        })
        
        dataTask.resume()
        
    }
}
