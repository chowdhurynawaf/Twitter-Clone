//
//  NotificationCell.swift
//  Twitter Clone App
//
//  Created by as on 10/9/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

protocol NotificationCellDelegate : class{
    func didTapProfileImage(_ cell:NotificationCell)
    func didTapFollowBtn(_ cell:NotificationCell)
}

class NotificationCell : UITableViewCell {
    
    
    
    //MARK: - Properties
    
     var notification : Notificaton? {
        didSet {
            configure()
        }
    }
    
    weak var delegate : NotificationCellDelegate?
    
    private lazy var profileImageView = Utilities.shared.createProfileImageView()
    private lazy var followButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Loading", for: .normal)
        btn.backgroundColor = .white
        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.twitterBlue.cgColor
        btn.addTarget(self, action: #selector(handleFollowTapped), for: .touchUpInside)
        return btn
    }()
    
    
    
    
    let notificaitonLabel : UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "some text"
        return label
    }()

    //MARK: - Lifecycle
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleImageBtnTapped))
        addGestureRecognizer(tap)
        
        let stack = UIStackView(arrangedSubviews: [
        profileImageView,
        notificaitonLabel
        ])
        
        stack.spacing = 8
        stack.alignment = .center
        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        stack.anchor(right:rightAnchor,paddingRight: 12)
        
        addSubview(followButton)
        followButton.centerY(inView: self)
        followButton.anchor(right:rightAnchor,paddingRight: 12)
        followButton.setDimensions(width: 88, height: 32)
        followButton.layer.cornerRadius = 32/2
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //MARK: - API


    //MARK: - Selectors

    //MARK: - helpers
    
    func configure() {
        
        guard let notification = notification else {
            return
        }
        
        let viewModel = NotificationViewModel(notification: notification)
        
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        notificaitonLabel.attributedText = viewModel.notificationText
        
        followButton.isHidden = viewModel.shouldHideFollow
        followButton.setTitle(viewModel.followString, for: .normal)
        
        
    }
    
    @objc func handleImageBtnTapped() {
        delegate?.didTapProfileImage(self)
    }
    
    @objc func handleFollowTapped() {
        delegate?.didTapFollowBtn(self)
    }


}
