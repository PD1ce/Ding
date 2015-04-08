//
//  User.swift
//  Ding
//
//  Created by Philip Deisinger on 4/7/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var email: String
    @NSManaged var firstName: String
    @NSManaged var id: NSNumber
    @NSManaged var password: String
    @NSManaged var startDate: NSDate
    @NSManaged var tasksCompleted: NSNumber
    @NSManaged var totalExp: NSNumber
    @NSManaged var totalLevel: NSNumber
    @NSManaged var userName: String
    @NSManaged var voicePack: NSNumber
    @NSManaged var colorScheme: NSNumber
    @NSManaged var achievements: NSSet
    @NSManaged var goals: NSSet
    @NSManaged var skills: NSSet
    
}
