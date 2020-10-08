
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
    
    private var tweets = [Tweet]() {
       didSet{collectionView.reloadData()}
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
    


    //MARK: - Selectors

    //MARK: - helpers
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(ProfileHeader.self,
                               forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:headerIdentifier)
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reusableIdentifier)
        collectionView.contentInsetAdjustmentBehavior = .never
    }


    

}

//MARK: - UICollectionViewDataSource

extension ProfileController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.item]
        return cell
    }
}

//MARK: - UICollectionViewFlowLayout


extension ProfileController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 120)
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

            }
        }
        
        
    }
    
    func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
    
    
}






    
    





