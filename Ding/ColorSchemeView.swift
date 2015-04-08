//
//  ColorSchemeView.swift
//  Ding
//
//  Created by Philip Deisinger on 4/7/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit

class ColorSchemeView : UIView {
    var schemeNumber: Int!
    
    init(frame: CGRect, num: Int) {
        super.init(frame: frame)
        schemeNumber = num
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
