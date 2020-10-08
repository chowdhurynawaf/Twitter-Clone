//
//  ActionSheetCell.swift
//  Twitter Clone App
//
//  Created by as on 10/6/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

class ActionSheetCell : UITableViewCell {
    
    
    //MARK: - Properties
    
    var option : ActionSheetOptions? {
         didSet {
             configure()
         }
     }
    
    private let optionImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.image = #imageLiteral(resourceName: "TwitterLogo")
        return imgView
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "test option"
        return label
    }()


    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(optionImageView)
        optionImageView.centerY(inView: self)
        optionImageView.anchor(left:leftAnchor,paddingLeft: 8)
        optionImageView.setDimensions(width: 36, height: 36)
        
        addSubview(titleLabel)
        titleLabel.anchor(left:optionImageView.rightAnchor,paddingLeft: 12)
        titleLabel.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - API


    //MARK: - Selectors

    //MARK: - helpers
    
    func configure() {
        titleLabel.text = option?.description
    }


}
