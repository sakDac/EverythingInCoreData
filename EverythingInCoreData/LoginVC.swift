//
//  ViewController.swift
//  EverythingInCoreData
//
//  Created by saket bhushan on 18/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit

protocol AuthenticationDelegate: class {
    func LoginSuccess()
    func LoginFailed()
}

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var userNameTextEdit: UITextField!
    
    @IBOutlet weak var passwordTextEdit: UITextField!
    
    @IBOutlet weak var errorLbl: UILabel!
    
    
    var coreDataManger = CoreDataManager.shared
    
    let errorText = "Please Enter correct user name or password."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorLbl.isHidden = true
        self.errorLbl.text = self.errorText
//        self.addSampleProfiles()
//        self.addSampleInvestment()
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
    
    @IBAction func editingDidBegan(_ sender: UITextField) {
        self.errorLbl.isHidden = true
        
        
    }
    
    
    func addSampleProfiles() {
        for i in 1 ... 10 {
        let profile = Profile(context: self.coreDataManger.context)
            profile.name = "friend : " + "\(i)"
            profile.userName = "friend : " + "\(i)"
            profile.password = "friend : " + "\(i)"
            profile.address = "friend address : " + "\(i)"
            profile.mobileNumber = 9958
            profile.id = UUID.init().uuidString
        }
        self.coreDataManger.save()
    }
    
    func addSampleInvestment() {
        for i in 1 ... 10 {
            let investment = Investment(context: self.coreDataManger.context)
            investment.company = "company : " + "\(i)"
            investment.id = UUID.init().uuidString
            investment.planName = "plan : " + "\(i)"
            investment.profileId = "profile : " + "\(i)"
        }
        self.coreDataManger.save()
    }
    
}

extension LoginVC : AuthenticationDelegate {
    func LoginSuccess() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    func LoginFailed() {
        self.errorLbl.isHidden = false
    }
    
    
}
