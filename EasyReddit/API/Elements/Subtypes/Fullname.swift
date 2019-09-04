//
//  FullName.swift
//  EasyReddit
//
//  Created by Lucas Sas on 04.09.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation


import Foundation

public class Fullname {
    let uniqueID: String
    let type: String
    
    
    init(type: String, uniqueID: String) {
        self.uniqueID = uniqueID
        self.type = type
    }
    
    func asString() -> String{
        // uniqueid muss vllt noch in base12 umgewandelt werden
        return "\(type)_\(uniqueID)"
    }
}
