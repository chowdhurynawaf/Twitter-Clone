//
//  User.swift
//  Twitter Clone App
//
//  Created by as on 9/23/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

struct User {
    let email : String
    let fullname : String
    let password : String
    var profileImageURL : URL?
    let userName : String
    
    let uid  : String
    
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
