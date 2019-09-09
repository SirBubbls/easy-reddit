//
//  Action.swift
//  reddit
//
//  Created by Lucas Sas on 03.09.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation

public class Action {
    
    // Change vote on a post or comment
    public static func vote(value: VoteType, id: Fullname) -> Bool {
        let dir: Int
        
        switch value {
        case .Downvote:
            dir = -1
        case .Upvote:
            dir = 1
        case .Neutral:
            dir = 0
        }
        
        // Configuring API Call
        let call = ApiCall(method: "/api/vote", requestType: "POST")
        call.requiresAuth = true
        call.addParameters(parameters: ["dir": "\(dir)", "id": id.asString()])
        
        
        do {
            print(try call.execute())
        } catch {
            NSLog("Unable to Vote")
            return false
        }
        
        return true
    }
    
    public static func save(id: Fullname) -> Bool {
        let call = ApiCall(method: "/api/save", requestType: "POST")
        call.requiresAuth = true
        call.addParameters(parameters: ["id": id.asString()])
        
        do {
            print(try call.execute())
            return true
        } catch {
            NSLog("Unable to Save")
            return false
        }
    }
    
    public static func unsave(id: Fullname) -> Bool {
        let call = ApiCall(method: "/api/unsave", requestType: "POST")
        call.requiresAuth = true
        call.addParameters(parameters: ["id": id.asString()])
        
        do{
            print(try call.execute())
            return true
        } catch {
            NSLog("Unable to Unsave")
            return false
        }
    }
}
