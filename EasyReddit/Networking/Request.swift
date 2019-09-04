//
//  Request.swift
//  reddit
//
//  Created by Lucas Sas on 08.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation
//import SwiftyJSON


public class Request {
    var request: URLRequest
    
    init(url: URL) {
        self.request = URLRequest(url: url)
    }
    
    init(request: URLRequest) {
        self.request = request
    }
    
    // TODO: should probably return Optional (JSON?) in case of no Internet Connection
    public func makeRequest() -> JSON {
        
        // Empty Json return values will be written into this variable
        var json = JSON()
        
        // Session thats gets used for recieving data
        let session = URLSession.shared
        
        // We need a Semaphore so we can return the data thats get returned by session.dataTask
        let sem = DispatchSemaphore(value: 0)
        
        
        let task = session.dataTask(with: self.request) { data, response, error in
            
            if let data = data { // Data is present
                do{
                    
                    // Writing parsed json data into result variable
                    json = try JSON(data: data)
                    
                }catch{print("ERROR")}
            }else { // No Data Recieved
                
                // Priting Error Message
                // TODO: Exception Handling
                NSLog("Request Error:\n\(error)")
                NSLog("URL: \(self.request.url!)")
                
            }
            sem.signal()
        }
        
        // Unlock Semaphore
        task.resume()
        
        // Executing Task
        
        
        // Waiting for finished 'task'
        sem.wait()
        
        // Returning result JSON
        return json
    }
}




public class GetRequest: Request {
    
    //    init(url: URL){
    //        super.init(url: url)
    //    }
    
}




public class PostRequest: Request {
    
    init(url: URL, credentials: String, postData: String = "") {
        // Constructor
        super.init(url: url)
        
        // Configuration for POST Request
        self.request.httpMethod = "POST"
        self.request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Authentication Data
        let authenticationData = credentials.data(using: .utf8)?.base64EncodedString()
        
        print("Authentication", authenticationData!)
        
        self.request.setValue("Basic \(authenticationData!)", forHTTPHeaderField: "Authorization")
        
        // Body Data
        self.request.httpBody = postData.data(using: .utf8)
    }
}

