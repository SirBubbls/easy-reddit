//
//  More.swift
//  EasyReddit
//
//  Created by Lucas Sas on 09.09.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation

public class More: DataType {
    public static let kind: String = "more"
    
    public let fullname: Fullname
    public let count: Int
    public let parentId: Fullname
    public let depth: Int
    public let children: [String]?
    
    init(data: JSON) {
        
        fullname = Fullname(fromString: data["data"]["name"].stringValue)
        count = data["count"].int ?? 0
        parentId = Fullname(fromString: data["data"]["parent_id"].stringValue)
        depth = data["depth"].int ?? 0
        
        if let values = data["data"]["children"].array {
            self.children = values.compactMap({$0.string ?? ""})
        } else {
            self.children = nil
        }

        super.init(kind: "more")
    }
}
