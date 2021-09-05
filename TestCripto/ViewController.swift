//
//  ViewController.swift
//  TestCripto
//
//  Created by user153132 on 9/4/21.
//  Copyright © 2021 user153132. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isEcryptMode: Bool!
    
    @IBOutlet weak var secret: UITextField!
    @IBOutlet weak var iv: UITextField!

    @IBOutlet weak var inputField: UITextView!
    @IBOutlet weak var outputField: UITextView!
    
    @IBAction func btnRun(_ sender: UIButton) {
        let cond1 = (secret.text != "")
        let cond2 = (iv.text != "")
        if cond1 && cond2{
            inputField.text = "foo"
        } else {
            inputField.text = "bar"
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isEcryptMode = false
        // Do any additional setup after loading the view, typically from a nib.
    }
}
