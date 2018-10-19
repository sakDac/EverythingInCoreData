//
//  CreateProfileVC.swift
//  EverythingInCoreData
//
//  Created by saket bhushan on 18/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit

class CreateProfileVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var mobileNumber: UITextField!
    
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var reenterPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createProfileClick(_ sender: UIButton) {
        
       let name = self.nameTextField.text
       let userName = self.userName.text
       let mobileNumber = self.mobileNumber.text
       let address = self.address.text
       let password = self.password.text
       let reEnterpwd = self.reenterPassword.text

        if (name?.trimmingCharacters(in: .whitespaces) == "" || userName?.trimmingCharacters(in: .whitespaces)  == "" || mobileNumber?.trimmingCharacters(in: .whitespaces)   == "" || address?.trimmingCharacters(in: .whitespaces)  == "" || password?.trimmingCharacters(in: .whitespaces)  == "" ||
            reEnterpwd?.trimmingCharacters(in: .whitespaces)  == "" ) {
            print("returning 1")
            return
        }
        
        if (password == reEnterpwd) {
            let profile = Profile(context: CoreDataManager.shared.context)
            profile.name = name
            profile.userName = userName
            profile.mobileNumber = Int16(mobileNumber ?? "0") ?? 0
            profile.address = address
            profile.password = password
            profile.id = UUID.init().uuidString
            CoreDataManager.shared.save()
            self.dismiss(animated: true, completion: nil)
        } else {
            print("returning 3")
            return
        }
        
        
    }
}
