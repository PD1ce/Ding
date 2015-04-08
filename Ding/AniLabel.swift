//
//  AniLabel.swift
//  Ding
//
//  Created by Philip Deisinger on 3/30/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit

class AniLabel : UILabel {
    
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