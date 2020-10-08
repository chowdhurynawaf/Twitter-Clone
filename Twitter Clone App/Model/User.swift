//
//  User.swift
//  Twitter Clone App
//
//  Created by as on 9/23/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit
import Firebase

struct User {
    let email : String
    let fullname : String
    let password : String
    var profileImageURL : URL?
    let userName : String
    var isFollowed = false
    var stats : UserRelationStats?
    
    let uid  : String
    
    var iscurrentUser : Bool {
        Auth.auth().currentUser?.uid == uid
    }
    
    init(uid:String ,dictionary:[String:AnyObject]) {
        self.uid = uid
        
        self.email     = dictionary["email"] as? String ?? ""
        self.fullname  = dictionary["fullname"] as? String ?? ""
        self.password  = dictionary["password"] as? String ?? ""
        self.userName   = dictionary["userName"] as? String ?? ""
        
        if let profileImageURL = dictionary["profileImageURL"] as? String {
            guard let url = URL(string: profileImageURL) else {return}
            self.profileImageURL = url
        }

    }
}

struct UserRelationStats {
    let follower : Int
    let following : Int
}
