
//
//  NotificationViewModel.swift
//  Twitter Clone App
//
//  Created by as on 10/9/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

class NotificationViewModel {
    private let notification : Notificaton
    private let type : NotificaitonType
    private let user : User
    
    
       var timeStampString: String? {
        let formatter: DateComponentsFormatter = DateComponentsFormatter()
        formatter.allowedUnits = [NSCalendar.Unit.second, NSCalendar.Unit.minute, NSCalendar.Unit.hour, NSCalendar.Unit.day, NSCalendar.Unit.weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = DateComponentsFormatter.UnitsStyle.abbreviated
        let now: Date = Date()
        return formatter.string(from: notification.timestamp, to: now)!
    }
    
    var notificationMessage : String {
        switch type{
            
        case .like:
            return "liked your tweet"
        case .follow:
            return "started to followed you"
        case .retweet:
            return "retweeted your tweet"
        case .reply:
            return "replied to your tweet"
        case .mention:
            return "mentioned you in a tweet"
        }
    }
    
    var notificationText : NSAttributedString? {
        guard let timeStamp = timeStampString else {return nil}
        let attributedTitle = NSMutableAttributedString(string: user.userName, attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14),
                                                        NSMutableAttributedString.Key.foregroundColor : UIColor.darkGray ]  )
        
        attributedTitle.append(NSMutableAttributedString(string: notificationMessage, attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14),
                                                        NSMutableAttributedString.Key.foregroundColor : UIColor.lightGray ]  ))
        
        attributedTitle.append(NSMutableAttributedString(string: " • \(timeStamp) ", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14),
        NSMutableAttributedString.Key.foregroundColor : UIColor.lightGray ]  ))
        
        return attributedTitle
            
        }
    
    var profileImageURL : URL? {
        return user.profileImageURL
    }
    
    var shouldHideFollow: Bool{
        return type != .follow
    }
    
    var followString  : String {
        return user.isFollowed ? "Following" : "Follow"
    }

    
    init(notification:Notificaton) {
        self.notification = notification
        self.type = notification.type
        self.user = notification.user
    }
    
}
