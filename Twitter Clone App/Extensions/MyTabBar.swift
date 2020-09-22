////
////  MyTabBar.swift
////  Twitter Clone App
////
////  Created by as on 9/17/20.
////  Copyright © 2020 nawaf. All rights reserved.
////
//
//import UIKit
//
//@IBDesignable class MyTabBar: UITabBar {
//
//    let higherTabBarInset: CGFloat = 24
//
//    lazy var isIphoneXOrHigher: Bool = {
//        return UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height >= 2436
//    }()
//
//    lazy var TAB_BAR_HEIGHT: CGFloat = {
//        // Return according to default tab bar height
//        if GlobalData.isIphoneXOrHigher {
//            return 83 + higherTabBarInset
//        }
//        else {
//            return 49 + higherTabBarInset
//        }
//    }()
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        if #available(iOS 13.0, *) {
//            self.standardAppearance.compactInlineLayoutAppearance = UITabBarItemAppearance.init(style: .stacked)
//            self.standardAppearance.inlineLayoutAppearance = UITabBarItemAppearance.init(style: .stacked)
//            self.standardAppearance.stackedLayoutAppearance = UITabBarItemAppearance.init(style: .stacked)
//            self.standardAppearance.stackedItemPositioning = .centered
//        }
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        var size = super.sizeThatFits(size)
//        size.height = TAB_BAR_HEIGHT
//        return size
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        self.items?.forEach({ e in
//            if #available(iOS 13.0, *) {
//                e.standardAppearance = self.standardAppearance
//            }
//            else {
//                e.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -(higherTabBarInset / 2))
//            }
//        })
//    }
//}
