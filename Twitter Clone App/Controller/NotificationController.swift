//
//  NotificationController.swift
//  Twitter Clone App
//
//  Created by as on 9/16/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit
private let reuseIdentifier = "NotificationCell"

class NotificationController: UITableViewController {
    
    
    
    // MARK: - Properties
    
    var notificaitons = [Notificaton]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        configureUI()
        fetchNotification()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Api
    
    func fetchNotification() {
        
        refreshControl?.beginRefreshing()
        NotificatonService.shared.fetchNotification { notifications in
            self.refreshControl?.endRefreshing()
            self.notificaitons = notifications
            
            for(index,notification) in notifications.enumerated() {
                if case .follow = notification.type{
                    let user = notification.user
                    
                    UserService.shared.checkIfUserIsFollowed(uid: user.uid) { isFollowed in
                        self.notificaitons[index].user.isFollowed = isFollowed
                    }
                }
            }
            
        }
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Notificatons"
        
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        
    }
    
    //MARK: - Selectors

    @objc func handleRefresh() {
        fetchNotification()
    }
    
    
}




//MARK: - Datasource

extension NotificationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificaitons.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        cell.notification = notificaitons[indexPath.row]
        cell.delegate = self
        return cell
    }
}

//MARK: - Delegate


extension NotificationController : NotificationCellDelegate {
    func didTapFollowBtn(_ cell: NotificationCell) {
        
        
        guard let user = cell.notification?.user else {return}
        
        if user.isFollowed {
            UserService.shared.unfollowUsers(uid: user.uid) { (err, ref) in
                cell.notification?.user.isFollowed = false
            }
        }
            
        else{
            UserService.shared.followUsers(uid: user.uid) { (err, ref) in
                cell.notification?.user.isFollowed = true
            }
        }
    }
    
    func didTapProfileImage(_ cell: NotificationCell) {
        guard let user = cell.notification?.user else {return}
        
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension NotificationController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notification = notificaitons[indexPath.row]
        guard let tweetID = notification.tweetID else {return}
        
        TweetService.shared.fetchTweet(withTweetId: tweetID) { (tweet) in
            let controller = TweetController(tweet: tweet)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
