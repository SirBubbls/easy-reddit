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
    public let fullname: Fullname
    public let language: String
    public let subredditType: String
    public let title: String
    public let displayNamePrefixed: String
    public let over18: Bool
    public let subscriber: Int
    public let iconImage: URL
    public let displayName: String
    
    init(json: JSON) {
        fullname = Fullname(type: Subreddit.kind, uniqueID: json["id"].stringValue)
        language = json["lang"].stringValue
        title = json["title"].stringValue
        displayNamePrefixed = json["display_name_prefixed"].stringValue
        over18 = json["over18"].boolValue
        subscriber = json["subscribers"].intValue
        iconImage = URL(string: json["icon_img"].stringValue) ?? URL(string: "https://b.thumbs.redditmedia.com/VZX_KQLnI1DPhlEZ07bIcLzwR1Win808RIt7zm49VIQ.png")!
        subredditType = json["subreddit_type"].stringValue
        displayName = json["display_name"].stringValue
        
    }
    
    func getInfo() {
        print("\(displayName) - \(subscriber)")
    }
}
