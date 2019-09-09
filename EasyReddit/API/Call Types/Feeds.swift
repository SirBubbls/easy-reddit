//
//  Feeds.swift
//  reddit
//
//  Created by Lucas Sas on 08.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation


public class Feeds {
    
    public static func best() {
        let call = ApiCall(method: "/best", requestType: "GET")
        
        do{
            print(try call.execute())
        }catch{
            print("Error")
        }
    }
    
    
    public static func subredditByName(subredditName: String, after: Fullname?) -> [RedditLink]? {
        let call = ApiCall(method: "/r/\(subredditName).json", requestType: "GET")

        // Adding Parameter
        if let after = after {
            call.addParameters(parameters: ["after": after.asString(), "limit": "5"])
        }
        
        // Request
        do{
            let response: JSON = try call.execute()
        
            let data = response["data"]["children"].arrayValue
            
            let result: [RedditLink] = Parser.parse(data: data) as! [RedditLink]
            
            return result
        }catch{
            print("Error")
        }
        
        return nil
    }
    
    public static func defaultSubreddits(after: String?) -> [RedditLink]?{
        let call = ApiCall(method: "/best", requestType: "GET")
        
        
        // Adding Parameter
        if let after = after {
            call.addParameters(parameters: ["after": after])
        }
        
        call.requiresAuth = true
        
        // Request
        do{
            let response: JSON = try call.execute()
            let data = response["data"]["children"].arrayValue
            
            let result: [RedditLink]? = Parser.parse(data: data) as! [RedditLink]?
            
            return result
        }catch{
            NSLog("API Call Error (\(call.requestType))")
        }
        
        return nil
    }
}
