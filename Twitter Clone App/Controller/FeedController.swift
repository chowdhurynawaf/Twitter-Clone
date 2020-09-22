//
//  FeedController.swift
//  Twitter Clone App
//
//  Created by as on 9/16/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

class FeedController : UITabBarController {
    
    // MARK: - Properties
    
    
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
    
    
 

}
