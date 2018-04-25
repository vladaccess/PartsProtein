//
//  EatViewController.swift
//  PartsProtein
//
//  Created by attom on 25.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit
import CoreMotion


class EatViewController: UIViewController {
    
    @IBOutlet weak var smallButton:UIButton!
    @IBOutlet weak var largeButton:UIButton!
    @IBOutlet weak var addButton:UIButton!
    @IBOutlet weak var starButton:UIButton!
    @IBOutlet weak var minusButton:UIButton!
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var maskImage:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Eat!"
    }

}
