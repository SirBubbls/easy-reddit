//
//  Comments.swift
//  reddit
//
//  Created by Lucas Sas on 04.09.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation


public class Comments {
    
    static public func fetchComments(permalink: String, parameters: [String: String]?) -> [RedditComment]? {
        
//        let method:String = "/r/\(subreddit)/comments/\(article.asString())"
        
        let call: ApiCall = ApiCall(method: permalink, requestType: "GET")
        
        call.addParameters(parameters: ["limit": "50"])
        
        
        if let parameters = parameters {
            call.addParameters(parameters: parameters)
        }
        
        
        call.requiresAuth = true
        
        let data: JSON
        
        do {
            data = JSON(try call.execute())
        } catch {
            print("not possible")
            return nil
        }
        
        
        let comments: [JSON] = data.array![1]["data"]["children"].array!
//        print(comments.first!)
        let parsed = Parser.parse(data: comments) as! [RedditComment]
        
        NSLog("Comments fetched \(parsed.count)")
        return parsed
        
    }
    
    
    
    
    static public func fetchMoreChildren() -> [RedditComment]? {
        
        let call: ApiCall = ApiCall(method: "/api/morechildren", requestType: "GET")
        
        call.requiresAuth = true
        
        
        return nil
    }
}
