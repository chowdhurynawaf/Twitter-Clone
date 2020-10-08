//
//  UserCell.swift
//  Twitter Clone App
//
//  Created by as on 10/2/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    //MARK: - Properties
    
    var user : User? {
        didSet{
            configure()
        }
    }
    
    private lazy var profileImageView : UIImageView = {
        
         let iv = UIImageView()
         iv.contentMode = .scaleAspectFill
         iv.clipsToBounds = true
         iv.setDimensions(width: 40, height: 40)
         iv.layer.cornerRadius = 40 / 2
         iv.backgroundColor = .lightGray
        return iv
         
     }()
    
    private lazy var fullnameLabel : UILabel = {
        let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "nameLabel"
         return label
         
     }()
    
    private lazy var userNameLabel : UILabel = {
        let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 14)
        label.text = "uesrname"
         label.textColor = .lightGray
         return label
         
     }()


    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        configUI()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configUI() {
       
        addSubview(profileImageView)
            profileImageView.centerY(inView: self, leftAnchor:leftAnchor,paddingLeft: 12)
            
            let stackView = UIStackView(arrangedSubviews: [
            
            fullnameLabel,
            userNameLabel
            
            ])
        
        stackView.spacing = 2
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.centerY(inView: profileImageView,leftAnchor: profileImageView.rightAnchor,paddingLeft: 12)
        
        
    }
    
    func configure() {
        
        guard let user = user else {
            return
        }
        
        profileImageView.sd_setImage(with: user.profileImageURL)
        fullnameLabel.text = user.fullname
        userNameLabel.text = user.userName
    }
    
}
