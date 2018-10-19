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
            } else {
                self.authenticationDelegate?.LoginFailed()
            }
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
}
