//
//  UploadTweetController.swift
//  Twitter Clone App
//
//  Created by as on 9/23/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit



class UploadTweetController: UIViewController {
    
    
    
    //MARK: - Properties
    
    private let user : User
    private let captionView = CaptionTextView()
    private let config : UploadTweetConfiguration
    private lazy var viewModel = UploadTweetViewModel(config: config)
    
    private lazy var replyLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        label.text = "whats happening"
        return label
    }()
    
    
    private lazy var actionButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .twitterBlue
        btn.setTitle("Tweet", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(.white, for: .normal)
        
        btn.setDimensions(width: 64, height: 32)
        btn.layer.cornerRadius = 32/2
        
        btn.addTarget(self, action: #selector(handleTweetBtn), for: .touchUpInside)
        return btn
    }()
    
    
    private let profileImageView : UIImageView = {
       
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        return iv
        
    }()
    
    //MARK: - Lifecycle

    init(user:User ,config : UploadTweetConfiguration) {
        self.user = user
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureUI()
        switch config {
        case .tweet:
            print("tweet")
        case .reply(let tweet):
            print("reply")
        }
    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTweetBtn() {
        
        guard let caption = captionView.text else {return}
        TweetService.shared.uploadTweet(caption: caption, type: config) { (err, ref) in
            
            
            if let err = err {
                print("tweet error")
                return
            }
            
            if case .reply(let tweet) = self.config {
                NotificatonService.shared.uploadNotification(type: .reply, tweet: tweet)
            }
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        
        let imageStackView = UIStackView(arrangedSubviews: [profileImageView,captionView])
        imageStackView.spacing = 8
        imageStackView.alignment = .leading
        
        let stackView = UIStackView(arrangedSubviews: [replyLabel,imageStackView])
//        stackView.alignment = .leading
        stackView.spacing = 12
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.anchor(top:view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor , right:view.rightAnchor, paddingTop: 16 ,paddingLeft: 16 , paddingRight: 16)
        profileImageView.sd_setImage(with: user.profileImageURL, completed: nil)
        
        actionButton.setTitle(viewModel.actionButtontitle, for: .normal)
        captionView.placeHolder.text = viewModel.placeholdertext
        replyLabel.isHidden = !viewModel.shouldShowReply
        
        guard let replyText = viewModel.replyText else {return}
        replyLabel.text = replyText
        


        
        
        

    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .twitterBlue
         navigationController?.navigationBar.isTranslucent = false
         navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
         navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }




}

