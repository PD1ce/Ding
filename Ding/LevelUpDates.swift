//
//  LevelUpDates.swift
//  Ding
//
//  Created by Philip Deisinger on 3/16/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class LevelUpDates: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var level: NSNumber
    @NSManaged var skill: Ding.Skill

}
