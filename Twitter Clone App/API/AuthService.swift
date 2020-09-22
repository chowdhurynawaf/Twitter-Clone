//
//  AuthService.swift
//  Twitter Clone App
//
//  Created by as on 9/22/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit
import Firebase

struct AuthCredential {
    let email : String
    let password : String
    let fullName : String
    let userName : String
    let profileImage : UIImage
    
}

struct AuthService {
   static let shared = AuthService()
    
    
    func logUserIn(withEmail email : String , password : String , complition : AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: complition)
    }
    
    
    func registerUser(credential : AuthCredential , completion : @escaping (Error?,DatabaseReference)->Void){
        
        let email = credential.email
        let password = credential.password
        let fullName = credential.fullName
        let userName = credential.userName
        
        guard let imageData = credential.profileImage.jpegData(compressionQuality: 0.3) else {return}
        let fileName = NSUUID().uuidString
        
        let storageRef = STORAGE_PROFILE_IMAGE.child(fileName)
        
        storageRef.putData(imageData, metadata: nil) { (meta, err) in
            storageRef.downloadURL { (url, err) in
                guard let profileimageURL = url?.absoluteString else {return}
                
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("Error : " ,error.localizedDescription)
                        return
                    }
                    
                    guard let uid = result?.user.uid else {return}
                    
                    let values = ["email":email , "password":password , "fullname":fullName , "userName":userName , "profileImageURL":profileimageURL]
                    
                    
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                    
                }
                
            }
        }
        
    }
}
