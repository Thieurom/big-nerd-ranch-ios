//
//  Line.swift
//  TouchTracker
//
//  Created by Doan Le Thieu on 3/21/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation
import CoreGraphics

struct Line {
    var begin = CGPoint.zero
    var end = CGPoint.zero
}

extension Line {
    var angle: CGFloat {
        let dx = end.x - begin.x
        let dy = end.y - begin.y

        return atan2(dy, dx)
    }
}
