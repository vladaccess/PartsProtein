//
//  FeedbackViewController.swift
//  PartsProtein
//
//  Created by attom on 27.05.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func negativeAction() {
        self.dismiss(animated: true)
    }
    
    @IBAction func sureAction() {
        self.dismiss(animated: true) {
//            UIApplication.shared.open(<#T##url: URL##URL#>, options: <#T##[String : Any]#>, completionHandler: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
        }
    }

}
