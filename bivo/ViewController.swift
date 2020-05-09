//
//  ViewController.swift
//  bivo
//
//  Created by vamsi on 5/8/20.
//  Copyright © 2020 com.vamsi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    let officialPIN = "1234"
    
    @IBOutlet weak var pin: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPushed(_ sender: Any) {
        let enteredPIN = pin.text
        if(enteredPIN == officialPIN) {
            self.performSegue(withIdentifier: "loginPassed", sender: self)
        }
    }
    

    


}

