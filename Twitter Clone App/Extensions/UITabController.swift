//
//  UITabController.swift
//  Twitter Clone App
//
//  Created by as on 9/17/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

extension UITabBar {

   override open func sizeThatFits(_ size: CGSize) -> CGSize {
       return CGSize(width: UIScreen.main.bounds.width, height: 200)
   }
}
