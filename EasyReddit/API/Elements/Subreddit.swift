//
//  File.swift
//  reddit
//
//  Created by Lucas Sas on 12.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation


public class Subreddit: DataType {
    public static let kind: String = "t5"
    let fullname: Fullname
    let language: String
    let subredditType: String
    let title: String
    let displayName: String
    let over18: Bool
    let subscriber: Int
    let iconImage: URL
    
    init(json: JSON) {
        fullname = Fullname(type: Subreddit.kind, uniqueID: json["id"].stringValue)
        language = json["lang"].stringValue
        title = json["title"].stringValue
        displayName = json["display_name_prefixed"].stringValue
        over18 = json["over18"].boolValue
        subscriber = json["subscribers"].intValue
        iconImage = URL(string: json["icon_img"].stringValue) ?? URL(string: "https://b.thumbs.redditmedia.com/VZX_KQLnI1DPhlEZ07bIcLzwR1Win808RIt7zm49VIQ.png")!
        subredditType = json["subreddit_type"].stringValue
    }
    
    func getInfo() {
        print("\(displayName) - \(subscriber)")
    }
}
