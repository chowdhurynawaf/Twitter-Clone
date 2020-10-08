//
//  CaptionTextView.swift
//  Twitter Clone App
//
//  Created by as on 9/23/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

class CaptionTextView: UITextView {

   
    
    //MARK: - Properties
    
       var placeHolder : UILabel = {
      
        let lbl = UILabel()
            lbl.font = UIFont.systemFont(ofSize: 16)
            lbl.textColor = .darkGray
            lbl.text = "Whats Happening"
            return lbl
        
    }()

    //MARK: - Lifecycle
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .lightGray
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        
        addSubview(placeHolder)
        placeHolder.anchor(top:topAnchor,left:leftAnchor, paddingTop: 8 ,paddingLeft: 4 )
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInoutChange), name: UITextView.textDidChangeNotification, object: nil)
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError()
        
    }


    //MARK: - API


    //MARK: - Selectors
    
    @objc func handleTextInoutChange() {
        
        placeHolder.isHidden = !text.isEmpty
    }

    //MARK: - helpers

    


}
