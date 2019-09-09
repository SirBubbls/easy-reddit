//
//  Fullname.swift
//  reddit
//
//  Created by Lucas Sas on 12.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation

public class Fullname {
    let uniqueID: String
    let type: String
    
    
    public init(type: String, uniqueID: String) {
        self.uniqueID = uniqueID
        self.type = type
    }
    
    public init(fromString: String) {
        let parts = fromString.split(separator: "_")
        self.type = String(parts.first ?? "")
        self.uniqueID = String(parts.last ?? "")
    }
    
    public func asString() -> String {
        return "\(type)_\(uniqueID)"
    }
}
