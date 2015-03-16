//
//  User.swift
//  Ding
//
//  Created by Philip Deisinger on 3/16/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var email: String
    @NSManaged var password: String
    @NSManaged var tasksCompleted: NSNumber
    @NSManaged var totalLevel: NSNumber
    @NSManaged var username: String
    @NSManaged var skills: NSOrderedSet

}
