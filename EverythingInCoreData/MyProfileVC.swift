//
//  MyProfileVC.swift
//  EverythingInCoreData
//
//  Created by saket bhushan on 18/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit
import CoreData

class MyProfileVC: UIViewController {

    
    @IBOutlet weak var detailsTextView: UITextView!
    
    @IBOutlet weak var profileImg: UIImageView!
    
    var coreDataManager = CoreDataManager.shared
    
    var friendsList = [Friend]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImg.backgroundColor = UIColor.red
        self.profileImg.layer.cornerRadius = self.profileImg.frame.width/2
        self.profileImg.layer.masksToBounds = false
        self.profileImg.clipsToBounds = true
        
        self.title = "My Profile"
        let rightBarButton = UIBarButtonItem(title: "Add Friends", style: .plain, target: self, action: #selector(self.addFriends))
        
        let leftBarButton = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(self.SignOut))
//        navigationItem.rightBarButtonItems = [rightBarButton]
//        self.navigationController?.navigationItem.rightBarButtonItems = [rightBarButton] // this won't work.
        
        self.navigationItem.rightBarButtonItems =  [rightBarButton]
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        if !self.coreDataManager.isUserAlreadyLoggedIn() {
            self.presentLogin()
        }
    }
    
    func presentLogin() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.coreDataManager.getCurrentUserProfile { (profile) in
            self.formatString(profile: profile)
            self.friendsList.removeAll()
            for friend in profile.myFriends! {
                let frn = friend as! Friend
                self.friendsList.append(frn)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func formatString(profile: Profile)  {
        
        let text = "ID : " + profile.id!.prefix(5) + "\n\nUser Name :\t" + profile.userName!
        let text2 =    text + "\n\nName :\t" + profile.name! + "\n\nNMobile :\t"  + String(profile.mobileNumber)
        let text3 = text2 + "\n\nAddress :\t" + profile.address!
        self.detailsTextView.text = text3
    }
    
   @objc func addFriends() {
    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FRIENDSVC") as! FRIENDSVC
    self.navigationController?.pushViewController(vc, animated: true)
    }
   
    @objc func SignOut() {
        UserDefaults.standard.setValue(nil, forKey: "isUserLoggedIn")
        self.presentLogin()
    }
    
}

extension MyProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyProfileCell
        cell.textLabel?.text = self.friendsList[indexPath.row].myProfile?.name ?? "invalid row"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Friends"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
