//
//  PinkViewController.swift
//  sampleLaunch
//
//  Created by Anthony Sherbondy on 10/28/14.
//  Copyright (c) 2014 iosfd. All rights reserved.
//

import UIKit

class PinkViewController: UIViewController {

    @IBOutlet weak var blueView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onBackButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
