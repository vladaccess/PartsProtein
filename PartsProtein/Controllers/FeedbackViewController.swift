//
//  FeedbackViewController.swift
//  PartsProtein
//
//  Created by attom on 27.05.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {
    @IBOutlet weak var negativeButton:UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        negativeButton?.layer.borderColor = UIColor.white.cgColor
        negativeButton?.layer.borderWidth = 1.0
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
    
    @IBAction func contactAction() {
        self.dismiss(animated: true) {
            guard let url = URL(string:"mailto:vladaccess@outlook.com") else { return }
            UIApplication.shared.open(url)
        }
    }
    
}
