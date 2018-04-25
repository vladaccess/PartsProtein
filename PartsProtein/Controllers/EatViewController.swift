//
//  EatViewController.swift
//  PartsProtein
//
//  Created by attom on 25.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit
import CoreMotion
import UICountingLabel
import BAFluidView
import AMPopTip


class EatViewController: UIViewController {
    
    @IBOutlet weak var smallButton:UIButton!
    @IBOutlet weak var largeButton:UIButton!
    @IBOutlet weak var addButton:UIButton!
    @IBOutlet weak var starButton:UIButton!
    @IBOutlet weak var minusButton:UIButton!
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var maskImage:UIImageView!
    @IBOutlet weak var percentageLabel:UICountingLabel!
    
    var userDefaults = UserDefaults.groupUserDefaults()
    var progressMeter:BAFluidView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Eat!"
        initAnimation()
        
        percentageLabel.animationDuration = 1.5
        percentageLabel.format = "%d%%"
        
        
    }
    
    func updateUI() {}
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //Set up programmatically that avoid issues
        if progressMeter == nil {
            let width = containerView.frame.size.width
            guard let progressMeter = BAFluidView(frame: CGRect(x: 0, y: 0, width: width, height: width), maxAmplitude: 40, minAmplitude: 8, amplitudeIncrement: 1) else { return }
            progressMeter.fillColor = Tint.mainTint
            progressMeter.fillAutoReverse = false
            progressMeter.fillDuration = 1.5
            progressMeter.fillRepeatCount = 0
            progressMeter.backgroundColor = .clear
            containerView.insertSubview(progressMeter, belowSubview: maskImage)
            updateUI()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Global.showPopTipOnceForKey("HEALTH", userDefaults: userDefaults, popTipText: "You can enable HealthCenter in Settings", inView: view, fromFrame: CGRect(x:view.frame.width - 60,y:view.frame.height,width:1,height:1), direction: .up, color:Tint.tint_destructive)
    }
    

}
