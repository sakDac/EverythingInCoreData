//
//  FRIENDSVC.swift
//  EverythingInCoreData
//
//  Created by saket bhushan on 20/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit
import CoreData

class FRIENDSVC: UIViewController {
    
    var fetchedResultsController : NSFetchedResultsController<Profile>?
    let coreDataManager = CoreDataManager.shared
    var currentProfile: Profile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let friendsRequest =  NSFetchRequest<Profile>(entityName: "Profile")
        let profileId = UserDefaults.standard.value(forKey: "profileId") as! String
        let predicate = NSPredicate(format: "id != %@", profileId)
        friendsRequest.predicate = predicate
        friendsRequest.sortDescriptors = [.init(key: "name", ascending: true)]
        self.fetchedResultsController = NSFetchedResultsController<Profile>(fetchRequest: friendsRequest, managedObjectContext: coreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try self.fetchedResultsController?.performFetch()
        } catch  {
            print("error :: while fetching friends ")
        }
        
        self.coreDataManager.getCurrentUserProfile { (currentUserProfile) in
         self.currentProfile = currentUserProfile
        }
        
   }
    
    func isAFriend(id: String) -> Bool {
        for inFriend in  self.currentProfile.myFriends! {
            let frn = inFriend as! Friend
            if id == frn.myProfile?.id {
               return true
            }
        }
     return false
    }
    
    deinit {
        print(" deinit Friends vc")
        self.fetchedResultsController = nil
    }
}


extension FRIENDSVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FriendsCell
        cell.friendsDelegate = self
        let data = self.fetchedResultsController?.object(at: indexPath)
        cell.setData(profile: data!, isAFriend: self.isAFriend(id: (data!.id)!))
        cell.textLbl.text = self.fetchedResultsController?.object(at: indexPath).name!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

extension FRIENDSVC : FriendsDelegate {
    func turnedOn(profile: Profile) {
        print("turned on \(profile.name)")
        self.coreDataManager.addFriend(friendProfile: profile)
    }
    
    func turedOff(profile: Profile) {
        print("turned off \(profile.name)")
        self.coreDataManager.removeFriend(friendProfile: profile)
    }
    
}
