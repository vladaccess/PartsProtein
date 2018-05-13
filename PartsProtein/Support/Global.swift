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
import AMPopTip

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
        AHKActionSheet.appearance().blurTintColor = Tint.mainTint
        AHKActionSheet.appearance().separatorColor = UIColor(white: 1.0, alpha: 0.3)
        if let font = UIFont(name: "Avenir-Book", size: 16) {
            AHKActionSheet.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white,NSAttributedStringKey.font:font]
            AHKActionSheet.appearance().buttonTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white,NSAttributedStringKey.font:font]
            AHKActionSheet.appearance().cancelButtonTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white,NSAttributedStringKey.font:font]
        }
        
        if #available(iOS 11, *) {
            let bottomInsets = UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0.0
            AHKActionSheet.appearance().cancelButtonHeight = 44 + bottomInsets
        }
    }
    
    class func showPopTipOnceForKey(_ key:String,userDefaults:UserDefaults,popTipText:String,inView view:UIView,fromFrame frame:CGRect,direction:PopTipDirection = .down,color:UIColor = Tint.mainTint) {
        if !userDefaults.bool(forKey: key) {
            userDefaults.set(true, forKey: key)
            userDefaults.synchronize()
            let pop = PopTip()
            pop.bubbleColor = color
            guard let insets = (UIApplication.shared.delegate as! AppDelegate).window?.safeAreaInsets.bottom else { return }
            pop.offset = insets + 50
            pop.edgeMargin = 5
            pop.show(text: popTipText, direction: .up, maxWidth: 200.0, in: view, from: frame)
        }
        
    }
}
