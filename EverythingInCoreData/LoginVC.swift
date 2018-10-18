//
//  ViewController.swift
//  EverythingInCoreData
//
//  Created by saket bhushan on 18/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit

// Things to cover in core data.
/*
 * Basics
 * Relationships
 * Threadsafety
 * Multithreading
 * using multiple context
 * using multiple db file
 * using multiple datamodelfile
 * updation of model version
 * updation and migration of db
 * using predicates
 * optimising predicates
 * some less known things
 * core data theory
 * what makes core data faster
 */


class LoginVC: UIViewController {
    
    
    @IBOutlet weak var userNameTextEdit: UITextField!
    
    @IBOutlet weak var passwordTextEdit: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginClick(_ sender: UIButton) {
        
       let vc = UIStoryboard.init(name: "Main", bundle: Bundle.allBundles.first).instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
        
       print("\(self.passwordTextEdit.text), \(self.userNameTextEdit.text)")
        
        
        
        print("clicked")
    }
    
    
    @IBAction func signUpClick(_ sender: UIButton) {
        
        
    }
    
    
    
}

