//
//  TweetCell.swift
//  Twitter Clone App
//
//  Created by as on 9/29/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

protocol TweetDelegate : class {
    func handleProfileImageViewTap(_ cell:TweetCell)
    func hanldleCommentBtnTapped(_ cell:TweetCell)
    func handleLikeTapped(_ cell:TweetCell)
   }

class TweetCell : UICollectionViewCell {
    
   
    
    
    //MARK: - Properties
    
    var tweet : Tweet? {
        didSet{
            configure()
        }
    }
    
    private lazy var commentBtn = makeGroundedButtons(image: #imageLiteral(resourceName: "comment"),  selector: #selector(handleCommentBtn))
    private lazy var retweetBtn = makeGroundedButtons(image: #imageLiteral(resourceName: "retweet"), selector: #selector(handleRetweetBtn))
    private lazy var likeBtn = makeGroundedButtons(image: #imageLiteral(resourceName: "like"), selector: #selector(handleLikeBtn))
    private lazy var ShareBtn = makeGroundedButtons(image: #imageLiteral(resourceName: "share"), selector: #selector(handleShareBtn))
    
    weak var delegate : TweetDelegate?

    

    
    private lazy var profileImageView : UIImageView = {
       
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageViewTap))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        return iv
        
    }()
    
    private let captionLabel : UILabel =  {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "some caption label"
        return label
    }()
    
    
    private let replyLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "replying to @mak"
        return label
    }()
    
    private let infoLabel = UILabel()
    
    
    //MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame:frame)
        

        
        backgroundColor = .white
        
        addSubview(profileImageView)
        
        profileImageView.anchor(top:safeAreaLayoutGuide.topAnchor,left: leftAnchor,paddingTop: 8,paddingLeft: 8)
        
        let captionStackView = UIStackView(arrangedSubviews: [
        infoLabel,
        captionLabel
        ])

        captionStackView.axis = .vertical
        captionStackView.spacing = 4
        captionStackView.distribution = .fillProportionally
        
        let imageCaptionStack = UIStackView(arrangedSubviews: [profileImageView,captionStackView])
        imageCaptionStack.distribution = .fillProportionally
        imageCaptionStack.alignment = .leading
        imageCaptionStack.spacing = 12
        
        let stack = UIStackView(arrangedSubviews: [
        replyLabel,
        imageCaptionStack
        ])
        
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 8
        
        
        addSubview(imageCaptionStack)
        stack.anchor(top:topAnchor,left:leftAnchor,right:rightAnchor,paddingTop: 4,paddingLeft: 12,paddingRight: 12)
        
        let actionStack = UIStackView(arrangedSubviews: [
        commentBtn,
        retweetBtn,
        likeBtn,
        ShareBtn
        
        ])
        
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom:bottomAnchor,paddingBottom: 8)
        actionStack.spacing = 72
        actionStack.distribution = .fillEqually
        
        infoLabel.text = "some info for res"
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        
        let underLineView = UIView()
        underLineView.backgroundColor = .systemGroupedBackground
        addSubview(underLineView)
        underLineView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Selectors
    
    @objc func handleCommentBtn() {
        delegate?.hanldleCommentBtnTapped(self)
    }
    
    @objc func handleRetweetBtn() {
        
       }
    
    @objc func handleLikeBtn() {
        
        delegate?.handleLikeTapped(self)
        
       }
    
    @objc func handleShareBtn() {
        
       }
    
    @objc func handleProfileImageViewTap() {
        
        delegate?.handleProfileImageViewTap(self)
        
    }

    
    //MARK: - API

    
    //MARK: - Helpers
    
    func makeGroundedButtons(image:UIImage ,  selector : Selector)->UIButton {
       
        
        let btn = UIButton(type: .system)
        btn.setImage(image, for: .normal)
        btn.tintColor = .darkGray
        btn.setDimensions(width: 20, height: 20)
        btn.addTarget(self, action: selector, for: .touchUpInside)
        return btn
    }
    
    func configure() {
        
        
        
        guard let tweet = tweet else {return}
        
        let tweetVM = TweetViewModel(tweet: tweet)
        
        profileImageView.sd_setImage(with: tweetVM.profileImageUrl)
        infoLabel.attributedText = tweetVM.userInfoText
        captionLabel.text = tweetVM.messageText
        likeBtn.tintColor = tweetVM.likeButtonTintColor
        likeBtn.setImage(tweetVM.likeButtonImage, for: .normal)
        
        replyLabel.isHidden = tweetVM.shouldHideReply
        replyLabel.text = tweetVM.replyText
        
    }
    
    

    
}
