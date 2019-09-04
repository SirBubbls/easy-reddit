//
//  Link.swift
//  reddit
//
//  Created by Lucas Sas on 13.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation


public class RedditLink: DataType {
    public static let baseHeight: CGFloat = 200
    public static let kind: String = "t3"
    let fullname: Fullname
    let title: String
    let over18: Bool
    let score: Int
    let domain: String
    let permalink: String?
    let url: URL?
    let id: String
    let authorFullName: Fullname
    let author: String
    let subredditName: String
    let thumbnail: URL
    var postHeight: CGFloat?
    var image: NSImage? = nil
    var date: NSDate
    let commentCount: Int
    let source: String?
    let isVideo: Bool
    let isGif: Bool
    let videoUrl: String?
    let imageUrl: String?
    let voteType: VoteType
    let clicked: Bool
    let saved: Bool
    
    
    init(json: JSON) {
        print(json)
        title = json["title"].stringValue
        over18 = json["over_18"].boolValue
        score = json["score"].intValue
        domain = json["domain"].stringValue
        permalink = json["permalink"].stringValue
        commentCount = json["num_comments"].intValue
//        url = URL(string: json["url"].stringValue)
        id = json["id"].stringValue
        authorFullName = Fullname(type: RedditLink.kind, uniqueID: id)
        author = json["author"].stringValue
        subredditName = json["subreddit"].stringValue
        thumbnail = URL(string: json["thumbnail"].stringValue) ?? URL(string: "https://b.thumbs.redditmedia.com/036IHhRftq0KLHjpjyTYIpSkNK4navyCBUB6KytVUiw.jpg")!
        postHeight = nil
//        image = nil
        url = nil
        source = json["domain"].stringValue
        isVideo = json["is_video"].boolValue
        fullname = Fullname(type: RedditLink.kind, uniqueID: self.id)
        clicked = json["clicked"].boolValue
        
        if let value = json["likes"].bool {
            if value {
                voteType = .Upvote
            } else {
                voteType = .Downvote
            }
        } else {
            voteType = .Neutral
        }
        
        
        saved = json["saved"].boolValue
        
        
        let created = json["created_utc"].doubleValue
//        let timeInt = TimeInterval(
        
        date = NSDate(timeIntervalSince1970: created)
        let images: [JSON] = json["preview"]["images"].arrayValue
        
        if !images.isEmpty {
            let previews = images[0]["resolutions"].arrayValue

            self.imageUrl = previews[previews.count-1]["url"].stringValue.replacingOccurrences(of: "&amp;", with: "&")
//
////            image = Media.getPreview(url: URL(string: imageURL)!)
//
//            self.postHeight = RedditLink.calcHeight(width: previews[previews.count-1]["width"].intValue, height: previews[previews.count-1]["height"].intValue)
            
        }else{
            image = nil
            self.imageUrl = nil
        }
        
        
        // Checking for Video
        if isVideo {
            let media: JSON = json["media"]["reddit_video"]
            
            isGif = media["is_gif"].boolValue
            videoUrl = media["hls_url"].stringValue
        } else {
            isGif = false
            videoUrl = nil
        }
        
    }
    
    // Deprecated Function
    private static func calcHeight(width: Int, height: Int) -> CGFloat {

        let value: Float = Float(width) / Float(height)
        

        let height: Float = Float(300) * value
        return (CGFloat(height) + RedditLink.baseHeight)
    }
    
    private func loadImage(url: URL) -> NSImage? {
        return nil
    }
}
