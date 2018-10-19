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
 * core data Generic Funtions, https://codereview.stackexchange.com/questions/147005/swift-3-generic-fetch-request-extension, https://swifting.io/blog/2016/11/27/28-better-coredata-with-swift-generics/
 */


protocol AuthenticationDelegate: class {
    func LoginSuccess()
    func LoginFailed()
}

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var userNameTextEdit: UITextField!
    
    @IBOutlet weak var passwordTextEdit: UITextField!
    
    var coreDataManger = CoreDataManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func loginClick(_ sender: UIButton) {
        let userName = self.userNameTextEdit.text?.trimmingCharacters(in: .whitespaces)
        let pwd = self.passwordTextEdit.text?.trimmingCharacters(in: .whitespaces)
        self.coreDataManger.authenticationDelegate = self
        self.coreDataManger.validateUser(userName: userName ?? "", pwd: pwd ?? "")
    }
    
    
    @IBAction func signUpClick(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateProfileVC") as! CreateProfileVC
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
}

extension LoginVC : AuthenticationDelegate {
    func LoginSuccess() {
        DispatchQueue.main.async {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func LoginFailed() {
        print(" Authentucation failed. Try Again!")
    }
    
    
}
