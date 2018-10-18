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
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
