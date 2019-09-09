//
//  Listings.swift
//  reddit
//
//  Created by Lucas Sas on 10.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation


public class Listings {
    
    static func best() {
        let call = ApiCall(method: "/best", requestType: "GET")
        do {
            print(try call.execute())
        }catch{
            print("API Call Error 'Listings.best()'")
        }
        
    }
    
    
    static func hot() {
        let call = ApiCall(method: "/hot", requestType: "GET")
        do {
            print(try call.execute())
        }catch{
            print("API Call Error 'Listings.best()'")
        }
        
    }
}
