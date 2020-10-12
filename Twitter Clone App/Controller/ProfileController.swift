
//
//  ProfileController.swift
//  Twitter Clone App
//
//  Created by as on 9/30/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

private let reusableIdentifier = "TweetCell"
private let headerIdentifier = "ProfileHeader"

class ProfileController : UICollectionViewController {
    


    //MARK: - Properties
    
    private var user : User
    
    private var selectedFilters : ProfileFilterOptions = .tweets {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var tweets = [Tweet]()
    private var likedTweets = [Tweet]()
    private var replies = [Tweet]()
    
    private var currentDataSource : [Tweet]{
        switch selectedFilters{
            
        case .tweets:
            return tweets
        case .replies:
            return replies
        case .likes:
            return likedTweets
        }
    }
    
  
    
    

    //MARK: - Lifecycle
    
    init(user : User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchTweets()
        checkIfUserIsFollowed()
        fetchUserStats()
        fetchLikedTweets()
        fetchReplies()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        navigationController?.navigationBar.barStyle = .black // this line changes status bar color 
        navigationController?.navigationBar.isHidden = true
    }


    //MARK: - API
    
    
    func fetchTweets() {
        TweetService.shared.fetchTweets(forUser: user) { (tweets) in
            self.tweets = tweets
            self.collectionView.reloadData()
        }
    }
    
    func checkIfUserIsFollowed() {
        UserService.shared.checkIfUserIsFollowed(uid: user.uid) { (isFollowed) in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    func fetchUserStats() {
        UserService.shared.checkUserStats(uid: user.uid) { stats in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
    
    func fetchLikedTweets() {
        TweetService.shared.fetchLikes(forUser: user) { tweets in
            self.likedTweets = tweets
        }
    }
    
    func fetchReplies() {
        TweetService.shared.fetchReplies(forUser: user) { tweets in
            self.replies = tweets
        }
    }
    


    //MARK: - Selectors

    //MARK: - helpers
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(ProfileHeader.self,
                               forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:headerIdentifier)
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reusableIdentifier)
        collectionView.contentInsetAdjustmentBehavior = .never
        
        guard let tabHeight = tabBarController?.tabBar.frame.height else {return}
        collectionView.contentInset.bottom = tabHeight
    }


    

}

//MARK: - UICollectionViewDataSource

extension ProfileController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentDataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! TweetCell
        cell.tweet = currentDataSource[indexPath.item]
        return cell
    }
}

//MARK: - UICollectionViewFlowLayout


extension ProfileController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return .init(width: view.frame.width, height: 120)
//    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = TweetController(tweet: currentDataSource[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //This function makes tweet cells dynamic
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let viewModel = TweetViewModel(tweet: currentDataSource[indexPath.item])
        var height = viewModel.size(forWidth: view.frame.width).height + 72
        
        if currentDataSource[indexPath.row].isreply{
            height = height + 20
        }
        
        return .init(width: view.frame.width, height: height)
    }

}


//MARK: UICollectionReusableViewHeader
extension ProfileController  {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        header.user = user
        header.delegate = self
        return header
    }
}

extension ProfileController : ProfileHeaderDelegate {
    func didSelect(filter: ProfileFilterOptions) {
        self.selectedFilters = filter
    }
    
    func editProfileOrFollowBtnTapped(_ header: ProfileHeader) {
        
        if user.iscurrentUser {
            return
        }
        
        if user.isFollowed {
            UserService.shared.unfollowUsers(uid: user.uid) { (err, ref) in
                self.user.isFollowed = false
//                header.editProfileOrFollowBtn.setTitle("Follow", for: .normal)
//                self.collectionView.reloadData()
                self.fetchUserStats()

                
            }
        }
        
        else{
            UserService.shared.followUsers(uid: user.uid) { (err, ref) in
                self.user.isFollowed = true
//                header.editProfileOrFollowBtn.setTitle("Following", for: .normal)
//                self.collectionView.reloadData()
                self.fetchUserStats()
                
                NotificatonService.shared.uploadNotification(type: .follow, user: self.user)

            }
        }
        
        
    }
    
    func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
    
    
}






    
    





