//
//  Ding.swift
//  Ding
//
//  Created by Philip Deisinger on 3/16/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class Ding: NSManagedObject {

    @NSManaged var skillname: String
    @NSManaged var level: NSNumber
    @NSManaged var expNeeded: NSNumber
    @NSManaged var expTotal: NSNumber
    @NSManaged var user: Ding.User
    @NSManaged var tasks: NSOrderedSet

}
