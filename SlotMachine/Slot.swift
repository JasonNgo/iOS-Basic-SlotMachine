//
//  Slot.swift
//  SlotMachine
//
//  Created by Jason Ngo on 2014-10-11.
//  Copyright (c) 2014 Jason Ngo. All rights reserved.
//

import Foundation
import UIKit

struct Slot {
    var number:Int
    var image:UIImage
    var isRed:Bool
    
    init (number:Int, image:UIImage, isRed:Bool) {
        self.number = number
        self.image = image
        self.isRed = isRed
    }
}