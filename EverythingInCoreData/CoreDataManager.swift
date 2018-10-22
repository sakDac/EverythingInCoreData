//
//  CoreDataManager.swift
//  EverythingInCoreData
//
//  Created by saket bhushan on 19/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
   
   static let shared = CoreDataManager()
   let delegate = UIApplication.shared.delegate as! AppDelegate
   let context: NSManagedObjectContext!
    weak var authenticationDelegate : AuthenticationDelegate?
    
   private init() {
    self.context = delegate.persistentContainer.viewContext
    }
    
    func save()  {
        do {
        try self.context.save()
            print("data saved successfully!")
        } catch let error {
            print("error occured :: \(error)")
        }
    }
    
    func validateUser(userName: String, pwd: String) {
        let predicate = NSPredicate(format: "userName == %@ AND password == %@", userName, pwd)
        self.fetchAll(enitityName: "Profile", predicate: predicate) { (result) in
            if result.count == 1 {
                self.authenticationDelegate?.LoginSuccess()
                guard let profile = result.first as? Profile, let id = profile.id else {
                    return
                }
                UserDefaults.standard.setValue(id, forKey: "profileId")
                UserDefaults.standard.setValue(true, forKey: "isUserLoggedIn")
            } else {
                self.authenticationDelegate?.LoginFailed()
            }
        }
    }
    
    func getCurrentUserProfile(comptionHandler: @escaping ((Profile) -> Void)) {
        let profileId = UserDefaults.standard.value(forKey: "profileId") as! String
        let predicate = NSPredicate(format: "id == %@", profileId)
        self.fetchAll(enitityName: "Profile", predicate: predicate) { (result) in
            guard let profile = result.first as? Profile else {
                return
            }
            comptionHandler(profile)
        }
        
    }
    
    
    func fetchAll(enitityName: String, predicate: NSPredicate? = nil ,completionHandler: @escaping(_ resultArr: [Any]) -> Void)  {
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: enitityName)
        if let pred = predicate {
            request.predicate = pred
        }
        let result = try? self.context.fetch(request)
        completionHandler(result!)
    }
    
    
    func addOrRemoveFriend(friendProfile: Profile, isAdd: Bool ) {
        let profileId = UserDefaults.standard.value(forKey: "profileId") as! String
        let predicate = NSPredicate(format: "id == %@", profileId)
        self.fetchAll(enitityName: "Profile", predicate: predicate) { (result) in
            guard let currentProfile = result.first as? Profile else {
                return
            }
            let friend = Friend(context: self.context)
            friend.myProfile = friendProfile
            if isAdd {
               currentProfile.addToMyFriends(friend)
            } else {
               currentProfile.removeFromMyFriends(friend)
            }
            self.save()
        }
    }
    
    
    
    func removeFriend(friendProfile: Profile) {
        let profileId = UserDefaults.standard.value(forKey: "profileId") as! String
        let predicate = NSPredicate(format: "id == %@", profileId)
        self.fetchAll(enitityName: "Profile", predicate: predicate) { (result) in
            guard let currentProfile = result.first as? Profile else {
                return
            }
            for inFriend in  currentProfile.myFriends! {
                let frn = inFriend as! Friend
                if friendProfile.id! == frn.myProfile?.id {
                    currentProfile.removeFromMyFriends(frn)
                    self.context.delete(frn)
                }
            }
            self.save()
        }
    }
    
    func isUserAlreadyLoggedIn() -> Bool  {
        if let isUserLoggedIn = UserDefaults.standard.value(forKey: "isUserLoggedIn") as? Bool {
            return isUserLoggedIn
        }
        return false
    }
    
    
}
