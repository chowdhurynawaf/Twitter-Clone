//
//  Constants.swift
//  Twitter Clone App
//
//  Created by as on 9/22/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import Firebase

let DB_REF = Database.database().reference()
let REF_USERS = Database.database().reference().child("users")
let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGE = STORAGE_REF.child("profile_Imagees")
let REF_TWEETS = DB_REF.child("tweets")
let REF_USER_TWEETS = DB_REF.child("user-tweets")
let REF_USER_FOLLOWERS = DB_REF.child("user-followers")
let REF_USER_FOLLOWING = DB_REF.child("user-following")
let REF_TWEET_REPLIES = DB_REF.child("tweet-replies")
let REF_USER_LIKES = DB_REF.child("uesr-likes")
let REF_TWEET_LIKES = DB_REF.child("tweet-likes")




//MARK: - Properties

//MARK: - Lifecycle


//MARK: - API


//MARK: - Selectors

//MARK: - helpers

