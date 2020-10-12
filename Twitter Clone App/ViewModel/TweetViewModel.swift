//
//  TweetViewModel.swift
//  Twitter Clone App
//
//  Created by as on 9/30/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

struct TweetViewModel {
    
    
    let tweet : Tweet
    let user : User
    
    var profileImageUrl : URL? {
        return user.profileImageURL
    }
    
    var userNameText : String {
        return "@\(user.userName)"
    }
    
    var headerTimeStamp : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a ・dd//MM//yyyy"
        return formatter.string(from: tweet.timestamp)
    }
    
       var timeStamp: String {
        let formatter: DateComponentsFormatter = DateComponentsFormatter()
        formatter.allowedUnits = [NSCalendar.Unit.second, NSCalendar.Unit.minute, NSCalendar.Unit.hour, NSCalendar.Unit.day, NSCalendar.Unit.weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = DateComponentsFormatter.UnitsStyle.abbreviated
        let now: Date = Date()
        return formatter.string(from: tweet.timestamp, to: now)!
    }
    
    var userInfoText : NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: user.fullname, attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14),
                                                        NSMutableAttributedString.Key.foregroundColor : UIColor.darkGray ]  )
        
        attributedTitle.append(NSMutableAttributedString(string: " @\(user.userName) ", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14),
                                                        NSMutableAttributedString.Key.foregroundColor : UIColor.lightGray ]  ))
        
        attributedTitle.append(NSMutableAttributedString(string: " • \(timeStamp) ", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14),
        NSMutableAttributedString.Key.foregroundColor : UIColor.lightGray ]  ))
        
        
        var retweetAttributedString : NSAttributedString? {
            return attributedText(withValue: tweet.retweetCount, text: "Retweet")
            
        }
        
        var likesAttributedString : NSAttributedString? {
            return attributedText(withValue: tweet.likes, text: "Likes")
        }
        
        
        return attributedTitle
    }
    
    
    var messageText : String {
        return tweet.caption
    }
    
    var likeButtonTintColor:UIColor {
        return tweet.didLike ? .red : .lightGray
    }
    
    var likeButtonImage : UIImage {
        let imageName = tweet.didLike ? "like_filled" : "like"
        return UIImage(named: imageName)!
    }
    
    var shouldHideReply : Bool {
        return !tweet.isreply
    }
    
    
    var replyText : String?{
        guard let replyingToUserName = tweet.replyingTo else {return nil}
        return "replying to @\(replyingToUserName)"
    }
    
    init(tweet:Tweet) {
        self.tweet = tweet
        self.user  = tweet.user
    }
    
    fileprivate func attributedText(withValue value : Int , text : String)->NSAttributedString {
           
           let attributedText = NSMutableAttributedString(string: "\(value)", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14) ]  )
                  
                  attributedText.append(NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14),
                                                                  NSMutableAttributedString.Key.foregroundColor : UIColor.lightGray ]  ))
           return attributedText
       }
    
    func size(forWidth width : CGFloat)->CGSize {
       
        let measurementLabel = UILabel()
        measurementLabel.text = tweet.caption
        measurementLabel.numberOfLines = 0
        measurementLabel.lineBreakMode = .byWordWrapping
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false
        measurementLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        return measurementLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
    }
       

    

}
