//
//  Subreddits.swift
//  reddit
//
//  Created by Lucas Sas on 10.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation

public class Subreddits {
//    static func defaultSubreddits() -> [Subreddit]?{
//        let call = ApiCall(method: "/best", requestType: "GET")
//        
//        var json = JSON()
//        
//        do{
//            print("Executing API Call")
//            json = try call.execute()
//            let postData = json["data"]["children"]
//            
//            
//            var posts = [Subreddit]()
//            for post in postData{
//                let tmp = Post(json: post.1)
//                posts.append(tmp)
//                tmp.getInfo()
//
//            }
//            return posts
//            
//        }catch{
//            print("Error")
//        }
//        
//        return nil
//    }
    
    public static func mySubreddits() -> [Subreddit]? {
        var result = [Subreddit]()
        let call = ApiCall(method: "/subreddits/mine/subscriber", requestType: "GET")
        var nextPointer: String = " "

        while nextPointer != "" {

            let data: JSON
            do{
                data = try call.execute()
            }catch{
                print("ERROR")
                data = JSON()
            }

            // Next Pointer
            nextPointer = data["data"]["after"].stringValue
            call.addParameters(parameters: ["after": nextPointer])

            for sub in data["data"]["children"]{
                let tmp = Subreddit(json: sub.1["data"])
                result.append(tmp)
            }
        }
        
        if result.isEmpty {return nil}
        
        return result
    }
    
    
    public static func subscribed(after: Fullname?) -> [Subreddit]? {
        let call = ApiCall(method: "/subreddits/mine/subscriber", requestType: "GET")
        
        if let after = after{
            call.addParameters(parameters: ["after": after.asString()])
        }

        do {
            let data: JSON = try call.execute()
            
            
            if let result = Parser.parseRequest(response: data) as! [Subreddit]? {
                return result
            }
        } catch {
            NSLog("[Error] Could not fetch Subreddits")
        }

        return nil
    }
}
