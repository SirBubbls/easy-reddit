//
//  Request.swift
//  reddit
//
//  Created by Lucas Sas on 08.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation



public class Request {
    var request: URLRequest
    
    init(url: URL) {
        self.request = URLRequest(url: url)
    }
    
    init(request: URLRequest) {
        self.request = request
    }
    
    // TODO: should probably return Optional (JSON?) in case of no Internet Connection
    public func makeRequest() -> JSON? {
        
        // Empty Json return values will be written into this variable
        var json: JSON?
        
        // Session thats gets used for recieving data
        let session = URLSession.shared
        
        // We need a Semaphore so we can return the data thats get returned by session.dataTask
        let sem = DispatchSemaphore(value: 0)
        
        
        let task = session.dataTask(with: self.request) { data, response, error in
            
            // Check for errors
            if let error = error {
                NSLog("\(error)")
                return
            }
            
            // Process data
            if let data = data {
                
                do{
                    json = try JSON(data: data)
                }catch{
                    NSLog("Could not process")
                    return
                }
            } else {
                NSLog("Request Error:\n\(error!)")
                NSLog("URL: \(self.request.url!)")
            }
            
            if let error = json!["message"].string {
                NSLog("Error \(error) (\(json!["error"].int ?? 0)) for \(self.request.url!.absoluteString)")
                return
            }
            
            sem.signal()
        }
        
        task.resume()

        // Waiting for finished 'task'
        sem.wait()
        
        // Returning result JSON
        return json
    }
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

