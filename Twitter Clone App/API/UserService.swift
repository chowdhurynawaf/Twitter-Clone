//
//  UserService.swift
//  Twitter Clone App
//
//  Created by as on 9/23/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit
import Firebase

typealias DatabaseCompletion = ((Error?,DatabaseReference)->Void)

struct UserService {
    
    static let shared = UserService()
    
    func fetchUser(uid:String,completion: @escaping (User)->Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String:AnyObject] else {return}
            
            let user = User(uid: uid, dictionary: dictionary)
            
            completion(user)
            
            
            
        }
    }
    
    func fetchUsers(completion: @escaping ([User])->Void) {
        var users = [User]()

        REF_USERS.observe(.childAdded) { (snapshot) in
            
            let uid = snapshot.key
            guard let dictionary = snapshot.value as? [String:AnyObject] else {return}
            
            let user = User(uid: uid, dictionary: dictionary)
            users.append(user)
            completion(users)
            
            
            }
    }
    
    func followUsers(uid:String,completion: @escaping(DatabaseCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        REF_USER_FOLLOWING.child(currentUid).updateChildValues([uid : 1]) { (err, ref) in
            REF_USER_FOLLOWERS.child(uid).updateChildValues([currentUid:1], withCompletionBlock: completion)
        }
    }
    
    func unfollowUsers(uid:String,completion: @escaping(DatabaseCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        REF_USER_FOLLOWING.child(currentUid).child(uid).removeValue { (err, ref) in
            REF_USER_FOLLOWERS.child(uid).child(currentUid).removeValue(completionBlock: completion)
        }
        
      
        }
    
    func checkIfUserIsFollowed(uid: String, completion: @escaping (Bool)->Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        REF_USER_FOLLOWING.child(currentUid).child(uid).observeSingleEvent(of: .value) { (snapshot) in
            completion(snapshot.exists())
        }

        
    }
    
    func checkUserStats(uid:String,completion:@escaping (UserRelationStats)->Void){
        REF_USER_FOLLOWERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            let follower = snapshot.children.allObjects.count
            
            REF_USER_FOLLOWING.child(uid).observeSingleEvent(of: .value) { (snapshot) in
                let following = snapshot.children.allObjects.count
                
                let stats = UserRelationStats(follower: follower, following: following)
                completion(stats)
            }
        }
    }
    
    
    
    
    }

