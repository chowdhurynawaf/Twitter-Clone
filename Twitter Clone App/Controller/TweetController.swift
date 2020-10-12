//
//  TweetController.swift
//  Twitter Clone App
//
//  Created by as on 10/4/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TweetCell"
private let headerIdentifier = "TweetHeader"

class TweetController : UICollectionViewController {
    

    
    //MARK: - Properties

    private let tweet : Tweet
    private var actionSheetLauncher : ActionSheetLauncher!
    private var replies = [Tweet]() {
        didSet{
            collectionView.reloadData()
        }
    }
    //MARK: - Lifecycle
    init(tweet:Tweet) {
        self.tweet = tweet
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchReplies()
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        navigationController?.navigationBar.barStyle = .black // this line changes status bar color
        navigationController?.navigationBar.isHidden = true
    }

    //MARK: - API

    func fetchReplies() {
        TweetService.shared.fetchReplies(forTweet: tweet) { (replies) in
            self.replies = replies
        }
    }

    //MARK: - Selectors

    //MARK: - helpers
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(TweetHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    
    fileprivate func showActionSheet(forUser user:User) {
        actionSheetLauncher = ActionSheetLauncher(user:tweet.user)
        self.actionSheetLauncher.delegate = self
        actionSheetLauncher.show()
    }

}


//MARK: - UICollecitonViewDataSource
extension TweetController {
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return replies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.tweet = replies[indexPath.item]
        return cell
    }
}

//MARK: - UICollectionViewFlowLayout

extension TweetController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let viewModel = TweetViewModel(tweet: tweet)
        let captionHeight = viewModel.size(forWidth: view.frame.width).height
        
        return CGSize(width: view.frame.width, height: captionHeight + 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

//MARK: UICollectionReusableViewHeader
extension TweetController  {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! TweetHeader
        header.delegate = self
        header.tweet = tweet
     
        return header
    }
}


//MARK:- TweethaeaderDelegate

extension TweetController : TweethaeaderDelegate {

    
    func showActionSheet() {
        
        if tweet.user.iscurrentUser{
            
            showActionSheet(forUser: tweet.user)

        }
        else{
            
            UserService.shared.checkIfUserIsFollowed(uid: tweet.user.uid) { (isFollowed) in
                var user = self.tweet.user
                user.isFollowed = isFollowed
                self.showActionSheet(forUser: user)
            }
        }
    }
    
    
}
extension TweetController : ActionSheetLauncherDelegate{
    func didselect(option: ActionSheetOptions) {
        
        switch option {
            
        case .follow(let user):
            UserService.shared.followUsers(uid: user.uid) { (err, ref) in
                
                
            }
        case .unfollow(let user):
             UserService.shared.unfollowUsers(uid: user.uid) { (err, ref) in
                         
                
                       }
        case .report:
            print("report")
        case .delete:
            print("delete")
            
        case .block:
            print("block")
        }
        
        
    }
    
    
}

