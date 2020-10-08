//
//  Utilities.swift
//  Twitter Clone App
//
//  Created by as on 9/18/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit




class Utilities {

    
    
     func inputContainerView(image:UIImage , textField : UITextField ) -> UIView {
        
        let view = UIView()
        let iv = UIImageView()
        view.addSubview(iv)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.image = image
    iv.anchor( left: view.leftAnchor, bottom:view.bottomAnchor, paddingLeft: 8, paddingBottom: 8, width: 24, height: 24)
        
        view.addSubview(textField)
        textField.anchor(left:iv.rightAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingLeft: 8,paddingBottom: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left:view.leftAnchor,bottom:view.bottomAnchor,right:view.rightAnchor,height: 0.75)
        
        return view
    }
    
     func textFieldConfigure(placeholder:String)->UITextField {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        tf.textColor = .white
        return tf
     
        
    }
    
    
    func attributedButton(_ firstPart: String , _ secondPart: String)-> UIButton {
        
        let btn = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16),
                                                        NSMutableAttributedString.Key.foregroundColor : UIColor.white ]  )
        
        attributedTitle.append(NSMutableAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 16),
                                                        NSMutableAttributedString.Key.foregroundColor : UIColor.white ]  ))
        
        btn.setAttributedTitle(attributedTitle, for: .normal)
        
        return btn
    }
    
   func createProfileImageView()->UIImageView {
        
             
              let iv = UIImageView()
              iv.contentMode = .scaleAspectFill
              iv.clipsToBounds = true
              iv.setDimensions(width: 48, height: 48)
              iv.layer.cornerRadius = 48 / 2
              iv.backgroundColor = .twitterBlue
              iv.isUserInteractionEnabled = true
              
          
        
        return iv
    }
    


   
    func createNameLabel() -> UILabel {
         var nameLabel : UILabel = {
            let label = UILabel()
             label.font = UIFont.boldSystemFont(ofSize: 20)
            label.text = "nameLabel"
             return label
             
         }()
        
        return nameLabel
    }
   
    func createUsernameLabel()->UILabel {

        
         var userNameLabel : UILabel = {
            let label = UILabel()
             label.font = UIFont.systemFont(ofSize: 16)
            label.text = "uesrname"
             label.textColor = .lightGray
             return label
             
         }()
        
        return userNameLabel
    }
    
   func createCaptionLabel()->UILabel {
    
             let captionLabel : UILabel =  {
             let label = UILabel()
             label.font = UIFont.systemFont(ofSize: 20)
             label.numberOfLines = 0
             label.text = "some caption label"
             return label
            
             
         }()
    
        return captionLabel
    }
    
    
    func createDateLabel()->UILabel {
        
        var dateLabel : UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.text = "06-11-12"
            label.textColor = .lightGray
            label.textAlignment = .left
            return label
            
        }()
        
        return dateLabel
    }

   

   
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
}
