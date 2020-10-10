//
//  Notification.swift
//  Twitter Clone App
//
//  Created by as on 10/8/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

enum NotificaitonType:Int {
    case like
    case follow
    case retweet
    case reply
    case mention
}

struct Notificaton {
    
    
    var tweetID : String?
    var user:User
//    var tweet : Tweet?
    var timestamp : Date!
    var type : NotificaitonType!
    
    init(user:User,/*tweet:Tweet,*/dictionary:[String:AnyObject]) {
        self.user = user
//        self.tweet = tweet
        
        
        if let tweetID = dictionary["tweetID"] as? String  {
            self.tweetID = tweetID
        }
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
        if let type = dictionary["type"] as? Int {
            self.type = NotificaitonType(rawValue: type)
        }
    }
    
}
