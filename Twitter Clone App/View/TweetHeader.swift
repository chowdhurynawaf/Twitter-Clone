//
//  TweetHeader.swift
//  Twitter Clone App
//
//  Created by as on 10/4/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit


protocol TweethaeaderDelegate:class {
    func showActionSheet()
}

class TweetHeader : UICollectionReusableView {
    
    
    //MARK: - Properties
    
    
    var tweet : Tweet! {
        didSet {
             configure()
        }
    }
    
    weak var delegate:TweethaeaderDelegate?
    
    private lazy var profileImageView = Utilities().createProfileImageView()
    private lazy var nameLabel = Utilities().createNameLabel()
    private lazy var usernameLabel = Utilities().createUsernameLabel()
    private lazy var captionLabel = Utilities().createCaptionLabel()
    private lazy var dateLabel = Utilities().createDateLabel()
    
    
    private lazy var commentBtn = makeGroundedButtons(image: #imageLiteral(resourceName: "comment"),  selector: #selector(handleCommentBtn))
    private lazy var retweetBtn = makeGroundedButtons(image: #imageLiteral(resourceName: "retweet"), selector: #selector(handleRetweetBtn))
    private lazy var likeBtn = makeGroundedButtons(image: #imageLiteral(resourceName: "like"), selector: #selector(handleLikeBtn))
    private lazy var ShareBtn = makeGroundedButtons(image: #imageLiteral(resourceName: "share"), selector: #selector(handleShareBtn))
    
    private lazy var opitonButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "down_arrow_24pt"), for: .normal)
        btn.tintColor = .lightGray
        btn.addTarget(self, action: #selector(optionBtnTapped), for: .touchUpInside)
        return btn
    }()
   
    private lazy var retweetLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "0 retweets "
        return label
    }()
    
    private lazy var likesLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "0 Likes"
        return label
    }()
    
    private lazy var statsView : UIView = {
       let view = UIView()
    
        let divider1 = UIView()
        divider1.backgroundColor = .systemGroupedBackground
        view.addSubview(divider1)
        divider1.anchor(top:view.topAnchor,left: view.leftAnchor,right:view.rightAnchor,paddingLeft: 8 , height: 1.0)
        
        
        let stack = UIStackView(arrangedSubviews: [
        retweetLabel,
        likesLabel

        ])
        
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.centerY(inView: view)
        stack.anchor(left:view.leftAnchor,paddingLeft: 16)
        
        let divider2 = UIView()
        divider2.backgroundColor = .systemGroupedBackground
        view.addSubview(divider2)
        divider2.anchor(left: view.leftAnchor,bottom: view.bottomAnchor,right:view.rightAnchor,paddingLeft: 8 , height: 1.0)
        
        
        return view
    }()
       
//       private lazy var nameLabel : UILabel = {
//           let label = UILabel()
//            label.font = UIFont.boldSystemFont(ofSize: 20)
//           label.text = "nameLabel"
//            return label
//
//        }()
//
//       private lazy var userNameLabel : UILabel = {
//           let label = UILabel()
//            label.font = UIFont.systemFont(ofSize: 16)
//           label.text = "uesrname"
//            label.textColor = .lightGray
//            return label
//
//        }()

    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("tweetcell")
        configureUI()
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - API


    //MARK: - Selectors
    
    @objc func handleImageBtnTapped() {
        print("tapped")
        
        
    }
    
    @objc func optionBtnTapped() {
        delegate?.showActionSheet()
    }
    
    
    @objc func handleCommentBtn() {
        
    }
    
    @objc func handleRetweetBtn() {
        
       }
    
    @objc func handleLikeBtn() {
        
       }
    
    @objc func handleShareBtn() {
        
       }

    //MARK: - helpers

    func configureUI() {
        let labelStackView = UIStackView(arrangedSubviews: [
        
            nameLabel,
            usernameLabel
        
        ])
        
        labelStackView.spacing = -6
        labelStackView.axis = .vertical
        
        
        let stackView = UIStackView(arrangedSubviews: [
              
                  profileImageView,
                  labelStackView
              
              ])
        stackView.spacing = 12
        addSubview(stackView)
        stackView.anchor(top:topAnchor,left: leftAnchor,paddingTop: 12,paddingLeft: 12)
        
        addSubview(captionLabel)
        captionLabel.anchor(top:stackView.bottomAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 20,paddingLeft: 16,paddingRight: 16)
        
        addSubview(dateLabel)
        dateLabel.anchor(top:captionLabel.bottomAnchor,left: leftAnchor,paddingTop: 10,paddingLeft: 16)
        
        addSubview(opitonButton)
        opitonButton.centerY(inView: stackView)
        opitonButton.anchor(right:rightAnchor,paddingRight: 8)
        
        addSubview(statsView)
        statsView.anchor(top:dateLabel.bottomAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 12 , height: 40)
        
        let actionStack = UIStackView(arrangedSubviews: [
        commentBtn,
        retweetBtn,
        likeBtn,
        ShareBtn
        
        ])
        
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.spacing = 72
        actionStack.anchor(top:statsView.bottomAnchor,paddingTop: 16)
        
        
    }
    
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
        
        let viewModel = TweetViewModel(tweet: tweet)
        
        captionLabel.text = viewModel.messageText
        nameLabel.text = viewModel.user.fullname
        usernameLabel.text = viewModel.userNameText
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        dateLabel.text = viewModel.headerTimeStamp
        
        likeBtn.setImage(viewModel.likeButtonImage, for: .normal)
        likeBtn.tintColor = viewModel.likeButtonTintColor
        
        
    }
    
  
}


