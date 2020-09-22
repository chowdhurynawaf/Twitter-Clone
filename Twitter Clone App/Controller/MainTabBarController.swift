//
//  MainTabBarController.swift
//  Twitter Clone App
//
//  Created by as on 9/16/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    let acitonButton : UIButton = {
        
        let btn = UIButton(type: .system)
        btn.backgroundColor = .twitterBlue
        btn.setImage(UIImage(named: "new_tweet"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(actionBtntapped), for: .touchUpInside)
        return btn
    }()
    
 
    
    // MARK: - LifeCycle

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        authinticateAndCOnfigureUI()

        
    }

   override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
       tabBar.frame.size.height = 60
       tabBar.frame.origin.y = view.frame.height - 95
   }
    
    
    //MARK: - API
    
    func authinticateAndCOnfigureUI() {
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
        else{
            configureUI()
            configureViewControllers()
        }
    }
    
    func LogoutUser() {
        
        do {
           try Auth.auth().signOut()
        }catch let error{
            print("problem getting logged out ",error.localizedDescription)
        }
    }
    
    
    // MARK: - Selectors
     
     @objc func actionBtntapped() {
         print("23")
     }
     
    
    
    

    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(acitonButton)
        acitonButton.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 80, paddingRight: 16, width: 56, height: 56)
        acitonButton.layer.cornerRadius = 56/2
        
    
        
    }
    
    func configureViewControllers() {
        
        let feed         = FeedController()
        let nav1         = templateNavigationController(image: #imageLiteral(resourceName: "home_unselected"), rootViewController: feed)
        let message      = MessageConttroller()
        let nav4         = templateNavigationController(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), rootViewController: message)
        let notifications = NotificationController()
        let nav3          = templateNavigationController(image: #imageLiteral(resourceName: "like_unselected"), rootViewController: notifications)
        let explore      = ExploreController()
        let nav2          = templateNavigationController(image: #imageLiteral(resourceName: "search_unselected"), rootViewController: explore)
        
        viewControllers = [nav1,nav2,nav3,nav4]
      
        
        
    }
    
    
    func templateNavigationController(image:UIImage, rootViewController : UIViewController)->UINavigationController
    {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.navigationBar.barTintColor = .white
        nav.tabBarItem.image = image
        return nav
    }
    
    

 

}