//
//  ProfileFilterView.swift
//  Twitter Clone App
//
//  Created by as on 9/30/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

protocol ProfileFilterViewDelegate : class {
    func filterView(_ view:ProfileFilterView,didSelect index:Int)
}

let resuableIdentifier = "ProfileFilterCell"

class ProfileFilterView : UIView {
    

    private let UnderLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
        
    }()
    
    
    //MARK: - Properties
    
    weak var delegate :ProfileFilterViewDelegate?
    
    
    lazy var collectionView : UICollectionView = {
       
        let Layout  = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: Layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
        
    }()

    //MARK: - Lifecycle
        override init(frame: CGRect) {
            super.init(frame:frame)
            
            let selectedIndexpath = IndexPath(row: 0, section: 0)
            collectionView.selectItem(at: selectedIndexpath, animated: true, scrollPosition: .left)
            
            collectionView.register(ProfileFilterCell.self, forCellWithReuseIdentifier: resuableIdentifier)
            addSubview(collectionView)
            collectionView.addConstraintsToFillView(self)
        }
    
        
    
    override func layoutSubviews() {
        addSubview(UnderLineView)
        UnderLineView.anchor(left:leftAnchor,bottom:bottomAnchor,width: frame.width/3,height: 2)
    }
    
        required init?(coder: NSCoder) {
            fatalError()
        }
    }

    //MARK: - API


    //MARK: - Selectors

    //MARK: - helpers

    



//MARK:- UICollectionViewDataSource



extension ProfileFilterView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileFilterOptions.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resuableIdentifier, for: indexPath) as! ProfileFilterCell
        
        let option = ProfileFilterOptions(rawValue: indexPath.item)
        cell.option = option!
        return cell
    }
    
    
}

//MARK:- UICollectionViewDelegate

extension ProfileFilterView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let xposition = cell?.frame.origin.x ?? 0
        
        UIView.animate(withDuration: 0.3) {
            self.UnderLineView.frame.origin.x = xposition
        }
        
        
        delegate?.filterView(self, didSelect: indexPath.row)
    }
    
}

//MARK:- UICollectionViewDelegateFlowLayout

extension ProfileFilterView : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(ProfileFilterOptions.allCases.count)
        return CGSize(width: frame.width/count , height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

