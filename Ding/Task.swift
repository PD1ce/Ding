//
//  Task.swift
//  Task
//
//  Created by Philip Deisinger on 3/16/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class Task: NSManagedObject {

    @NSManaged var taskname: String
    @NSManaged var exp: NSNumber
    @NSManaged var skill: Ding.Skill

}
