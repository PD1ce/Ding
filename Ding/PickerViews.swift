//
//  PickerViews.swift
//  Ding
//
//  Created by Philip Deisinger on 5/28/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit

class SkillPicker: UIPickerView {
    var id = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class TaskPicker: UIPickerView {
    var id = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
