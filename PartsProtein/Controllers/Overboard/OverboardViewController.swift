//
//  ViewController.swift
//  PartsProtein
//
//  Created by attom on 20.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit
import AMWaveTransition

class OverboardViewController: AMWaveViewController {
    
    @IBOutlet var viewArray:[UIView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        navigationController?.view.backgroundColor = Tint.mainTint
        view.backgroundColor = .clear
    }
    
    func updateUI() {
        
    }
    override func visibleCells() -> [Any]! {
        return viewArray
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    @IBAction func backButton(_ sender:UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    


}

