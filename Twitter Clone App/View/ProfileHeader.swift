
//
//  ProfileHeader.swift
//  Twitter Clone App
//
//  Created by as on 9/30/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

protocol ProfileHeaderDelegate : class {
    func handleDismissal()
    func editProfileOrFollowBtnTapped(_ header: ProfileHeader)
    func didSelect(filter:ProfileFilterOptions)
}

class ProfileHeader : UICollectionReusableView {
    
    
    //MARK: - Properties
    
    var user : User?{
        didSet {
            
            print("user set")
            configure()
        }
    }
    
    weak var delegate : ProfileHeaderDelegate?
    
    private let filterBar = ProfileFilterView()
    
    private lazy var backButton : UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()

    private lazy var containerView : UIView = {
       
        let view = UIView()
        view.backgroundColor = .twitterBlue
        view.addSubview(backButton)
        
        backButton.anchor(top:view.topAnchor,left:view.leftAnchor,paddingTop: 42,paddingLeft: 16)
        backButton.setDimensions(width: 30, height: 30)
        
        return view
    }()
    
    private lazy var profileImageView : UIImageView = {
        
         let iv = UIImageView()
         iv.contentMode = .scaleAspectFill
         iv.clipsToBounds = true
         iv.setDimensions(width: 80, height: 80)
         iv.layer.cornerRadius = 80 / 2
         iv.backgroundColor = .lightGray
         iv.layer.borderColor = UIColor.white.cgColor
         iv.layer.borderWidth = 4
        return iv
         
     }()
    
     lazy var editProfileOrFollowBtn : UIButton = {
       
        let button = UIButton(type: .system)
        button.setTitle("Loding", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.addTarget(self, action: #selector(editProfileOrFollowBtnTapped), for: .touchUpInside)
        button.setDimensions(width: 100, height: 36)
        button.layer.cornerRadius = 36/2
        return button
        
    }()
    
    private lazy var nameLabel : UILabel = {
        let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "nameLabel"
         return label
         
     }()
    
    private lazy var userNameLabel : UILabel = {
        let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 16)
        label.text = "uesrname"
         label.textColor = .lightGray
         return label
         
     }()
    
    private lazy var biolabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "This is a dummy bio man"
        label.numberOfLines = 3
        return label
        
    }()
    

    private let followersLabel : UILabel = {
        let label = UILabel()
        label.text = "0 Followers"
        
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowersTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        
        return label
        
    }()
    
    private let followingLabel : UILabel = {
        let label = UILabel()
        label.text = "0 Following"

        
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        
        return label
        
    }()
    

    
    
    
    //MARK: - Lifecycle
    
    
    override init(frame: CGRect) {
          super.init(frame: frame)
        
        filterBar.delegate = self
          
          backgroundColor = .white
        
         configureProfileHeaderUI()
      }
      
      required init?(coder: NSCoder) {
          fatalError()
      }


    //MARK: - API


    //MARK: - Selectors
    
    @objc func handleDismissal() {
        delegate?.handleDismissal()
    }
    
    @objc func editProfileOrFollowBtnTapped() {
        delegate?.editProfileOrFollowBtnTapped(self)
    }
    
    @objc func handleFollowersTapped() {
        
    }
    
    @objc func handleFollowingTapped() {
        
    }
    
    

    //MARK: - helpers
    
    
    func configure() {
        guard let user = user else {return}
        
        let viewModel = ProfileHeaderViewModel(user: user)
        
        editProfileOrFollowBtn.setTitle(viewModel.actionButtonTitle, for: .normal)
        profileImageView.sd_setImage(with: user.profileImageURL)
        followingLabel.attributedText = viewModel.followingString
        followersLabel.attributedText = viewModel.followersString
        nameLabel.text = viewModel.nameLabel
        userNameLabel.text = viewModel.userNamelabel
        
    }
    
    
    func configureProfileHeaderUI() {
        addSubview(containerView)
        containerView.anchor(top:topAnchor,left: leftAnchor,right: rightAnchor,height: 100)
        
        addSubview(profileImageView)
        
        profileImageView.anchor(top:containerView.bottomAnchor , left : leftAnchor , paddingTop: -24 , paddingLeft: 8)
        
        addSubview(editProfileOrFollowBtn)
        editProfileOrFollowBtn.anchor(top:containerView.bottomAnchor , right:rightAnchor ,paddingTop:12 , paddingRight: 12)
        
        let userDetailsStackView = UIStackView(arrangedSubviews: [
        nameLabel,
        userNameLabel,
        biolabel
        
        ])
        
        addSubview(userDetailsStackView)
        userDetailsStackView.anchor(top: profileImageView.bottomAnchor,left: leftAnchor,right:rightAnchor,paddingTop: 12,paddingLeft: 8,paddingRight: 8)
        userDetailsStackView.distribution = .fillProportionally
        userDetailsStackView.spacing = 8
        userDetailsStackView.axis = .vertical
        
        let followStackView = UIStackView(arrangedSubviews: [
        
        followingLabel,
        followersLabel
        
        ])
        
        followStackView.spacing = 8
        followStackView.distribution = .fillProportionally
        followStackView.axis = .horizontal
        
        addSubview(followStackView)
        followStackView.anchor(top:userDetailsStackView.bottomAnchor,left:leftAnchor,paddingTop: 4,paddingLeft: 8)
        
        
        addSubview(filterBar)
        filterBar.anchor(left:leftAnchor,bottom: bottomAnchor,right:rightAnchor,height: 50)
        

    }
 
}

extension ProfileHeader : ProfileFilterViewDelegate {
    func filterView(_ view: ProfileFilterView, didSelect index: Int) {
  
        guard let filter = ProfileFilterOptions(rawValue: index) else {return}
        delegate?.didSelect(filter: filter)
    }
     
    
    
    
    
}
