//
//  Achievement.swift
//  Ding
//
//  Created by Philip Deisinger on 3/17/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class Achievement: NSManagedObject {

    @NSManaged var achievementName: String
    @NSManaged var accomplishedDate: NSDate
    @NSManaged var completed: NSNumber
    @NSManaged var achievementDesc: String
    @NSManaged var exp: NSNumber
    @NSManaged var id: NSNumber
    @NSManaged var user: Ding.User

}
