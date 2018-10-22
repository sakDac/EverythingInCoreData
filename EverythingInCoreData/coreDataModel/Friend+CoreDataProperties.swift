//
//  Friend+CoreDataProperties.swift
//  EverythingInCoreData
//
//  Created by saket bhushan on 22/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var myProfile: Profile?

}
