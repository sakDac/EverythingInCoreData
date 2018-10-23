//
//  Investment+CoreDataProperties.swift
//  EverythingInCoreData
//
//  Created by saket bhushan on 22/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//
//

import Foundation
import CoreData


extension Investment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Investment> {
        return NSFetchRequest<Investment>(entityName: "Investment")
    }

    @nonobjc public class func getfetchRequest() -> NSFetchRequest<Investment> {
        return self.fetchRequest()
    }
    
    @NSManaged public var company: String?
    @NSManaged public var id: String?
    @NSManaged public var planName: String?
    @NSManaged public var profileId: String?
    @NSManaged public var buyer: NSSet?

}

// MARK: Generated accessors for buyer
extension Investment {

    @objc(addBuyerObject:)
    @NSManaged public func addToBuyer(_ value: Profile)

    @objc(removeBuyerObject:)
    @NSManaged public func removeFromBuyer(_ value: Profile)

    @objc(addBuyer:)
    @NSManaged public func addToBuyer(_ values: NSSet)

    @objc(removeBuyer:)
    @NSManaged public func removeFromBuyer(_ values: NSSet)

}
