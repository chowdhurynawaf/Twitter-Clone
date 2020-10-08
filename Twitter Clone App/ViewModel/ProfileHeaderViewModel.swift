
//
//  ProfileHeaderViewModel.swift
//  Twitter Clone App
//
//  Created by as on 10/1/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit


enum ProfileFilterOptions : Int , CaseIterable {
    case tweets
    case replies
    case likes

    
    var description : String {
        switch self {
        case .tweets:
            return "Tweets"
        case .replies:
            return "Tweets & Replies"
        case .likes:
            return "Likes"
  
            
        }
    }
}

struct ProfileHeaderViewModel {
    
    private let user : User
    
    
     init(user: User) {
         self.user = user
     }
    
    var followersString : NSAttributedString? {
        return attributedText(withValue: user.stats?.follower ?? 0, text: " Followers")
    }
    
    var followingString : NSAttributedString? {
        return attributedText(withValue: user.stats?.following ?? 0, text: " Following")
    }
    
    var nameLabel : String {
        return user.fullname
    }
    
    var userNamelabel : String {
        return "@\(user.userName)"
    }
    
    var actionButtonTitle : String {
        if user.iscurrentUser {
            return "Edit Profile"
        }
        
        if !user.isFollowed && !user.iscurrentUser {
            return "Follow"
        }
        
        if user.isFollowed {
            return "Following"
        }
        
        return "Loading"
    }
    
    
    
 
    
 fileprivate func attributedText(withValue value : Int , text : String)->NSAttributedString {
        
        let attributedText = NSMutableAttributedString(string: "\(value)", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14) ]  )
               
               attributedText.append(NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14),
                                                               NSMutableAttributedString.Key.foregroundColor : UIColor.lightGray ]  ))
        return attributedText
    }
    
    
}
