//
//  ViewController.swift
//  TestCripto
//
//  Created by user153132 on 9/4/21.
//  Copyright © 2021 user153132. All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {
    
    var isEcryptMode: Bool!
    
    @IBOutlet weak var secret: UITextField!
    @IBOutlet weak var iv: UITextField!

    @IBOutlet weak var inputField: UITextView!
    @IBOutlet weak var outputField: UITextView!
    let terpelCryptoHelper = TerpelCryptoHelper() // intancia del Helper
    
    @IBAction func btnRun(_ sender: UIButton) {
        let cond1 = (secret.text != "")
        let cond2 = (iv.text != "")
        let cond3 = (inputField.text != "")
        if cond1 && cond2 && cond3{
            let ivArray = terpelCryptoHelper.getArray(stringIn: iv.text)
            let keyArray = terpelCryptoHelper.getArray(stringIn: secret.text)
            if(isEcryptMode){
                outputField.text = terpelCryptoHelper.encrypt(iv: ivArray, key: keyArray, cleanText: inputField.text.bytes)
            } else {
                 outputField.text = terpelCryptoHelper.decrypt(iv: ivArray, key: keyArray , fullEncryptHex: inputField.text)
            }
            
        } else {
            outputField.text = "The fields Secret, IV and Input inforamtion are required."
            
        }
        
    }
    
    @IBAction func swMode(_ sender: Any) {
        isEcryptMode = !isEcryptMode
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        isEcryptMode = true
        defaultSetTestData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func defaultSetTestData(){
        secret.text = "RwcmlVpgRwcmlVpgRwcmlVpgRwcmlVpg"
        iv.text = "4e5Wa71fYoT7MFEX"
        inputField.text = ""
        
    }
}
