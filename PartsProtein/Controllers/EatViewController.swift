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
import Realm
import BubbleTransition


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
    var expanded = false
    var realmNotification:RLMNotificationToken?
    var manager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        [smallButton,largeButton,addButton].map { $0?.layer.cornerRadius = ($0?.bounds.size.width)!/2 }
        self.title = "Eat!"
        initAnimation()
        percentageLabel.animationDuration = 1.5
        percentageLabel.format = "%d%%"
        
        manager.accelerometerUpdateInterval = 0.01
        manager.deviceMotionUpdateInterval = 0.01
        manager.startDeviceMotionUpdates(to: OperationQueue.main) { (motion, error) in
            if let motion = motion {
                let rotation = atan2(motion.gravity.x, motion.gravity.y) - Double.pi
                self.progressMeter?.transform = CGAffineTransform(rotationAngle: CGFloat(rotation))
            }
        }
        
        
        realmNotification = EntryHandler.shared.realm.observe { (note, realm) in
            self.updateUI()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(EatViewController.updateUI), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
    }
    
    
    
    
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
            progressMeter = BAFluidView(frame: CGRect(x: 0, y: 0, width: width, height: width), maxAmplitude: 40, minAmplitude: 8, amplitudeIncrement: 1)
            progressMeter!.fillColor = Tint.mainTint
            progressMeter!.fillAutoReverse = false
            progressMeter!.fillDuration = 1.2
            progressMeter!.fillRepeatCount = 0
            progressMeter!.backgroundColor = .clear
            containerView.insertSubview(progressMeter!, belowSubview: maskImage)
            updateUI()
        }
        
        if !userDefaults.bool(forKey: "FEEDBACK") {
            if EntryHandler.shared.overAllQuantity() > 40 {
                animateStarButton()
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Global.showPopTipOnceForKey("HEALTH", userDefaults: userDefaults, popTipText: "You can enable HealthCenter in Settings", inView: view, fromFrame: CGRect(x:view.frame.width - 60,y:view.frame.height,width:1,height:1), direction: .up, color:Tint.tint_destructive)
    }
    
    // UpdateUI
    
    func updateCurrentEntry(_ delta:Double) {
        EntryHandler.shared.addPart(quantity: delta)
    }
    
    @objc func updateUI() {
        var percentage = EntryHandler.shared.currentPercentage()
        percentageLabel.countFromCurrentValue(to: CGFloat(round(percentage)))
        var fillTo = Double(percentage/100)
        if fillTo > 1 {
            fillTo = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.progressMeter?.fill(to: NSNumber(value: fillTo))
        }
    }
    
    
    // IBActions
    
    @IBAction func addButtonAction(_ sender:UIButton) {
        if expanded {
            self.contractAddButton()
        }else {
            self.expandedAddButton()
        }
    }
    
    @IBAction func removePartAction() {
        let alert = UIAlertController(title: "Undo", message: "Undo latest action", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default) { _ in
            EntryHandler.shared.removeLastPart()
        }
        let no  = UIAlertAction(title: "No", style: .default)
        [yes,no].forEach { alert.addAction($0) }
        self.present(alert, animated: true)  { }
    }
    
    
    @IBAction func selectionAction(_ sender:UIButton) {
        contractAddButton()
        Global.showPopTipOnceForKey("UNDO", userDefaults: userDefaults, popTipText: "Tap here to undo latest action", inView: view, fromFrame: minusButton.frame, direction: .down, color: Tint.mainTint)
        let portion = smallButton == sender ? Constants.Part.small.key() : Constants.Part.big.key()
        updateCurrentEntry(userDefaults.double(forKey: portion))
    }
    

}
