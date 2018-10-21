//
//  MyProfileVC.swift
//  EverythingInCoreData
//
//  Created by saket bhushan on 18/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit

class MyProfileVC: UIViewController {

    
    @IBOutlet weak var detailsTextView: UITextView!
    
    var coreDataManager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Profile"
        let rightBarButton = UIBarButtonItem(title: "Add Friends", style: .plain, target: self, action: #selector(self.addFriends))
//        navigationItem.rightBarButtonItems = [rightBarButton]
        
        self.navigationController?.navigationItem.rightBarButtonItems = [rightBarButton] // this won't work.
        
        self.navigationItem.rightBarButtonItems =  [rightBarButton]
        
        self.coreDataManager.getCurrentUserProfile { (profile) in
            self.formatString(profile: profile)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.coreDataManager.getCurrentUserProfile { (profile) in
            print(" profile :: \(profile) ")
            
            
            for friend in profile.myFriends! {
                
                let frn = friend as! Friend
                
                print("  friend :: \(frn.myProfile?.name) ")
            }
            
            
            
            
        }
    }
    
    
    func formatString(profile: Profile)  {
        let text = "ID : " + profile.id! + "\nUser Name : " + profile.userName!
        let text2 =    text + "\nName : " + profile.name! + "\nNMobile : "  + String(profile.mobileNumber)
        self.detailsTextView.text = text2
    }
    
   @objc func addFriends() {
    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FRIENDSVC") as! FRIENDSVC
    self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MyProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
}
