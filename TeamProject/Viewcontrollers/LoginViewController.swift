//
//  ViewController.swift
//  TeamProject
//
//  Created by Stanislav Testov on 16.04.2021.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        okButton.layer.cornerRadius = okButton.frame.height/2
    }


}

