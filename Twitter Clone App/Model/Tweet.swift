//
//  Tweet.swift
//  Twitter Clone App
//
//  Created by as on 9/28/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

struct Tweet {
    
    let caption : String
    let tweetID : String
    let uid : String
    var timestamp : Date!
    var likes : Int
    let retweetCount : Int
    let user : User
    var didLike = false
    
    
    init(user:User, tweetID: String , dictionary : [String:Any]) {
        self.user = user
        self.tweetID = tweetID
        self.uid = dictionary["uid"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetCount = dictionary["retweetCount"] as? Int ?? 0
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }

    }
    
}