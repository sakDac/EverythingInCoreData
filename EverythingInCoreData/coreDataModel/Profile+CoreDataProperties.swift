//
//  Profile+CoreDataProperties.swift
//  EverythingInCoreData
//
//  Created by saket bhushan on 22/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var address: String?
    @NSManaged public var id: String?
    @NSManaged public var mobileNumber: Int16
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var userName: String?
    @NSManaged public var investmentScheme: NSSet?
    @NSManaged public var myFriends: NSSet?

}

// MARK: Generated accessors for investmentScheme
extension Profile {

    @objc(addInvestmentSchemeObject:)
    @NSManaged public func addToInvestmentScheme(_ value: Investment)

    @objc(removeInvestmentSchemeObject:)
    @NSManaged public func removeFromInvestmentScheme(_ value: Investment)

    @objc(addInvestmentScheme:)
    @NSManaged public func addToInvestmentScheme(_ values: NSSet)

    @objc(removeInvestmentScheme:)
    @NSManaged public func removeFromInvestmentScheme(_ values: NSSet)

}

// MARK: Generated accessors for myFriends
extension Profile {

    @objc(addMyFriendsObject:)
    @NSManaged public func addToMyFriends(_ value: Friend)

    @objc(removeMyFriendsObject:)
    @NSManaged public func removeFromMyFriends(_ value: Friend)

    @objc(addMyFriends:)
    @NSManaged public func addToMyFriends(_ values: NSSet)

    @objc(removeMyFriends:)
    @NSManaged public func removeFromMyFriends(_ values: NSSet)

}
