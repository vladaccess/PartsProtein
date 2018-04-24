//
//  Global.swift
//  PartsProtein
//
//  Created by attom on 22.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import Foundation
import UIKit
import AHKActionSheet

class Global {
    class func numericToolBar(_ target:AnyObject?,selector:Selector,barColor:UIColor = .white,tintColor:UIColor = Tint.mainTint) -> UIToolbar {
        let numberToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolBar.barStyle = .blackTranslucent
        numberToolBar.barTintColor = barColor
        numberToolBar.tintColor = tintColor
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: target, action: nil)
        let button = UIBarButtonItem(title: "Ok", style: .done, target: target, action: selector)
        if let font = UIFont(name: "Avenir-Book", size: 16) {
            button.setTitleTextAttributes([NSAttributedStringKey.font:font,NSAttributedStringKey.foregroundColor:tintColor], for: UIControlState())
        }
        numberToolBar.sizeToFit()
        numberToolBar.isTranslucent = true
        numberToolBar.items = [space,button]
        return numberToolBar
    }
    
    class func actionSheetAppearance() {
        
    }
}
