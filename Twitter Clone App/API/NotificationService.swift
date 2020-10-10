//
//  NotificationService.swift
//  Twitter Clone App
//
//  Created by as on 10/8/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import Firebase


struct NotificatonService {
    static let shared = NotificatonService()
    
    func uploadNotification(type:NotificaitonType,tweet:Tweet? = nil,user:User? = nil) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        var values : [String:Any] = ["timestamp":Int(NSDate().timeIntervalSince1970),
                                     "uid":uid,
                                     "type":type.rawValue]
        
        if let tweet = tweet {
            values["tweetID"] = tweet.tweetID
            REF_NOTIFICATIONS.child(tweet.user.uid).childByAutoId().updateChildValues(values)
        }
        else{
            if let user = user {
                REF_NOTIFICATIONS.child(user.uid).childByAutoId().updateChildValues(values)
            }
        }
        
    }
    
    func fetchNotification(completion:@escaping([Notificaton])->Void) {
        var notifications = [Notificaton]()
        guard let uid  = Auth.auth().currentUser?.uid else {return}
        
        REF_NOTIFICATIONS.child(uid).observe(.childAdded) { (snapshot) in
            guard let dictionary = snapshot.value as? [String:AnyObject] else {return}
            guard let uid = dictionary["uid"] as? String else {return}
            
            UserService.shared.fetchUser(uid: uid) { (user) in
                let notification = Notificaton(user: user, dictionary: dictionary)
                notifications.append(notification)
                completion(notifications)
            }
            
        }
        
    }
}
