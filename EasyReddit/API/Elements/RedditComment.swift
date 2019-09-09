//
//  RedditComment.swift
//  reddit
//
//  Created by Lucas Sas on 13.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation

public class RedditComment: DataType {
    public static let kind: String = "t1"
    
    public let fullname: Fullname
    public let score: Int?
    public let date: NSDate
    public let author: String?
    public let subredditId: Fullname
    public let authorId: Fullname
    public let isSubmitter: Bool
    public let stickied: Bool
    public let replies: [RedditComment]?
    public let text: String?
    public let permalink: String
    public let html: String?
    public var depth: Int? = nil
    public var expanded: Bool = false
    public var more: More?
    
    public init(json: JSON) {
        self.fullname = Fullname(type: RedditComment.kind, uniqueID: json["id"].string!)
        self.score = json["score"].int
        self.date = NSDate(timeIntervalSince1970: json["created_utc"].doubleValue)
        self.author = json["author"].string
        self.subredditId = Fullname(fromString: json["subreddit_id"].stringValue)
        self.authorId = Fullname(fromString: json["author_id"].stringValue)
        self.isSubmitter = json["is_submitter"].boolValue
        self.stickied = json["stickied"].boolValue
        self.text = json["body"].stringValue
        self.permalink = json["permalink"].stringValue
        self.html = json["body_html"].string
        
        if let replies: [JSON] = json["replies"]["data"]["children"].array {
            self.replies = RedditComment.processReplies(data: replies)
            self.more = RedditComment.fetchMore(data: replies)
        } else {
            replies = nil
        }
        
        
        
        super.init(kind: "t1")
    }
    
    static func processReplies(data: [JSON]) -> [RedditComment]? {
        return Parser.parse(data: data) as! [RedditComment]?
    }
    
    
    static func fetchMore(data: [JSON]) -> More? {
        
        if data.last!["kind"].stringValue == More.kind {
            return More(data: data.last!)
        }
        
        return nil
    }
    
}

extension RedditComment: Equatable {
    public static func == (lhs: RedditComment, rhs: RedditComment) -> Bool {
        return
            lhs.fullname.asString() == rhs.fullname.asString()
    }
}
