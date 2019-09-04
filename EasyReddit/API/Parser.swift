//
//  Parser.swift
//  reddit
//
//  Created by Lucas Sas on 12.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation

public class Parser {
    
    static func parseRequest(response: JSON) -> [DataType] {
        let data = response["data"]["children"].array ?? [JSON]()
        
        return Parser.parse(data: data)
    }
    
    static func parse(data: [JSON]) -> [DataType] {
        var result = [DataType]()
        
        for point in data {
            
            switch point["kind"].stringValue {
            case RedditComment.kind:
                break
            case RedditAccount.kind:
                break
            case RedditLink.kind:
                let parsedData: RedditLink = RedditLink(json: point["data"])
                result.append(parsedData)
            case RedditMessage.kind:
                break
            case Subreddit.kind:
                let parsedData: Subreddit = Subreddit(json: point["data"])
                result.append(parsedData)
            case RedditAward.kind:
                break
            default:
                print("Unknown DataType '\(point["kind"].stringValue)'  Error")
                continue
            }
        }
        
        return result
    }
}
