//
//  FeedController.swift
//  Twitter Clone App
//
//  Created by as on 9/16/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class FeedController : UITabBarController {
    
    // MARK: - Properties
    
    var user : User? {
        didSet{
           configureLeftBarButton()
        }
    }
    
    
    // MARK: - LifeCycle


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureUI()
        
        
    }
    
    
    // MARK: - Helpers

    func configureUI() {
       // view.backgroundColor = .white
        let imageView = UIImageView(image: #imageLiteral(resourceName: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
       
    }
    
    func configureLeftBarButton() {
        
        
        guard let user = user else {return}
        
        
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .twitterBlue
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        
//        guard let profileImageURL = URL(string: user.profileImageURL) else {return}
        profileImageView.sd_setImage(with: user.profileImageURL, completed: nil)
               
               navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    
 

}
