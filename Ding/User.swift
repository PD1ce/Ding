//
//  User.swift
//  Ding
//
//  Created by Philip Deisinger on 3/17/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var email: String
    @NSManaged var password: String
    @NSManaged var tasksCompleted: NSNumber
    @NSManaged var totalLevel: NSNumber
    @NSManaged var userName: String
    @NSManaged var firstName: String
    @NSManaged var id: NSNumber
    @NSManaged var startDate: NSDate
    @NSManaged var skills: NSOrderedSet
    @NSManaged var goals: NSOrderedSet

}
