//
//  Account.swift
//  reddit
//
//  Created by Lucas Sas on 08.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation

public class Account {
    
    static func trophies() {
        let call = ApiCall(method: "/api/v1/me/trophies", requestType: "GET")
        
        do{
            print("Executing API Call")
            print(try call.execute())
        }catch{
            print("Error")
        }
        
    }
    
    static func me() {
        let call = ApiCall(method: "/api/v1/me", requestType: "GET")
        
        do{
            print("Executing API Call")
            print(try call.execute())
        }catch{
            print("Error")
        }
    }
    
    
}
