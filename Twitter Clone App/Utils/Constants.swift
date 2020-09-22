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
