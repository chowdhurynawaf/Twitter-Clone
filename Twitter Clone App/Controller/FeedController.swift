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


private let reuseIdenttifier = "TweetCell"

class FeedController : UICollectionViewController {
    
    // MARK: - Properties
    
    
   private var tweets = [Tweet]() {
    didSet{collectionView.reloadData()}
    }
    
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
        fetchTweets()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - API
    
    
    func fetchTweets() {
        
        
        TweetService.shared.fetchTweets { tweets in
            
            DispatchQueue.main.async {
                self.tweets = tweets
                self.checkIfUserLikedTweet(tweets)
                
            }
        }
    }
    
    
    // MARK: - Helpers
    
    
    func checkIfUserLikedTweet(_ tweets:[Tweet]) {
        for (index,tweet) in tweets.enumerated() {
            TweetService.shared.checkIfuserLikedTweet(tweet) { (didLike) in
                guard didLike == true else {return}
                
                self.tweets[index].didLike = true
            }
        }
    }

    func configureUI() {
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdenttifier)
        collectionView.backgroundColor = .white
        
       // view.backgroundColor = .white
        let imageView = UIImageView(image: #imageLiteral(resourceName: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
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

//MARK: - UICOllectionViewDelegate/DataSource

extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdenttifier, for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.item]
        cell.delegate = self
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = TweetController(tweet: tweets[indexPath.item])
        navigationController?.pushViewController(controller, animated: true)
    }

}

//MARK: - UICollectionViewDelegateFlowLayout

extension FeedController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let viewModel = TweetViewModel(tweet: tweets[indexPath.item])
        let height = viewModel.size(forWidth: view.frame.width).height
        
        return .init(width: view.frame.width, height: height+72)
    }
}

//MARK: - TweetDelegate

extension FeedController : TweetDelegate {
    func handleLikeTapped(_ cell: TweetCell) {
        
        
        guard let tweet = cell.tweet else {return}
        
        TweetService.shared.likeTweet(tweet: tweet) { (err, ref) in
            cell.tweet?.didLike.toggle()
            let likes = tweet.didLike ? tweet.likes-1 : tweet.likes + 1
            cell.tweet?.likes = likes
            
            guard !tweet.didLike else {return}
            NotificatonService.shared.uploadNotification(type: .like)
            
        }
    }
    
    func hanldleCommentBtnTapped(_ cell: TweetCell) {
        guard let tweet = cell.tweet else {return}
        
        let controller = UploadTweetController(user: tweet.user, config: .reply(tweet))
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    func handleProfileImageViewTap(_ cell:TweetCell) {
        
        guard let user = cell.tweet?.user else {return}
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
}
