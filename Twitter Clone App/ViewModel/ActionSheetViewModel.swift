//
//  ActionSheetViewModel.swift
//  Twitter Clone App
//
//  Created by as on 10/6/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

enum ActionSheetOptions {
    case follow(User)
    case unfollow(User)
    case report
    case delete
    case block
    
    var description : String {
        
        switch self {
            
        case .follow(let user):
            return "Follow @\(user.userName)"
        case .unfollow(let user):
            return "Unfollow @\(user.userName)"
        case .report:
            return "Report"
        case .delete:
            return "Delete"
        case .block:
            return "Block"
        }
    }
}

class ActionSheetViewModel {
    
    private let user : User
    
 
    
    var options : [ActionSheetOptions] {
        var results = [ActionSheetOptions]()
        
        if user.iscurrentUser {
            results.append(.delete)
        }else{
            let followOpiton : ActionSheetOptions = user.isFollowed ? .unfollow(user) : .follow(user)
            results.append(followOpiton)

        }
        
        results.append(.report)
        results.append(.block)

        
        return results
    }
    
    init(user:User) {
        self.user = user
    }
    

    

}
