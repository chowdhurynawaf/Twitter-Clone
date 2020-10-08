//
//  UploadTweetViewModel.swift
//  Twitter Clone App
//
//  Created by as on 10/6/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

enum UploadTweetConfiguration {
    case tweet
    case reply(Tweet)
}

struct UploadTweetViewModel  {
    let actionButtontitle : String
    let placeholdertext : String
    let shouldShowReply : Bool
    var replyText : String?
    
    init(config : UploadTweetConfiguration) {
        switch config {
        case .tweet:
            actionButtontitle = "Tweet"
            placeholdertext = "Whats Happening"
            shouldShowReply = false
        case .reply(let tweet):
               actionButtontitle = "Reply"
               placeholdertext = "Tweet your reply"
               shouldShowReply = true
               replyText = "replying to @\(tweet.user.userName)"
            
  
        }
    }
    
}
