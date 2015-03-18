//
//  LevelUpDate.swift
//  Ding
//
//  Created by Philip Deisinger on 3/17/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class LevelUpDate: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var level: NSNumber
    @NSManaged var skill: Ding.Skill

}
