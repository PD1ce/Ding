//
//  GoalView.swift
//  Ding
//
//  Created by Philip Deisinger on 5/24/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit

class GoalEdit: UIView {
    
    var originalFrame: CGRect!
    var originalOrigin: CGPoint!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        originalFrame = frame
        originalOrigin = frame.origin
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class NewGoalCard: UIView {
    
    var originalFrame: CGRect!
    var originalOrigin: CGPoint!
    var goalPos: Int!
    
    init(frame: CGRect, goalPos: Int) {
        super.init(frame: frame)
        originalFrame = frame
        originalOrigin = frame.origin
        self.goalPos = goalPos
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}