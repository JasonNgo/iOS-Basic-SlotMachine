//
//  Factory.swift
//  SlotMachine
//
//  Created by Jason Ngo on 2014-10-11.
//  Copyright (c) 2014 Jason Ngo. All rights reserved.
//

import Foundation
import UIKit

class Factory {
    class func createSlots() -> [[Slot]] {
        let kNumberOfSlots = 3
        let kNumberOfContainers = 3
        var slotColumns:[[Slot]] = []
        
        for (var i = 0; i < kNumberOfContainers; i++) {
            var slotArray:[Slot] = []
            for (var j = 0; j < kNumberOfSlots; j++) {
                var slot = createSlot(slotArray)
                slotArray.append(slot)
            }
            slotColumns.append(slotArray)
        }
        return slotColumns
    }
    
    class func createSlot(currentCards:[Slot]) -> Slot {
        var currentCardValues:[Int] = []
        for slot in currentCards {
            currentCardValues.append(slot.number)
        }
        
        var randonNumber = Int(arc4random_uniform(UInt32(13)) + 1)
        while contains(currentCardValues, randonNumber) {
            randonNumber = Int(arc4random_uniform(UInt32(13)) + 1)
        }
        
        var slot:Slot
        
        switch randonNumber {
        case 1:
            slot = Slot(number: 1, image: UIImage(named: "Ace"), isRed: true)
        case 2:
            slot = Slot(number: 2, image: UIImage(named: "Two"), isRed: true)
        case 3:
            slot = Slot(number: 3, image: UIImage(named: "Three"), isRed: true)
        case 4:
            slot = Slot(number: 4, image: UIImage(named: "Four"), isRed: true)
        case 5:
            slot = Slot(number: 5, image: UIImage(named: "Five"), isRed: false)
        case 6:
            slot = Slot(number: 6, image: UIImage(named: "Six"), isRed: false)
        case 7:
            slot = Slot(number: 7, image: UIImage(named: "Seven"), isRed: true)
        case 8:
            slot = Slot(number: 8, image: UIImage(named: "Eight"), isRed: false)
        case 9:
            slot = Slot(number: 9, image: UIImage(named: "Nine"), isRed: false)
        case 10:
            slot = Slot(number: 10, image: UIImage(named: "Ten"), isRed: true)
        case 11:
            slot = Slot(number: 11, image: UIImage(named: "Jack"), isRed: false)
        case 12:
            slot = Slot(number: 12, image: UIImage(named: "Queen"), isRed: false)
        case 13:
            slot = Slot(number: 13, image: UIImage(named: "King"), isRed: true)
        default:
            slot = Slot(number: 0, image: UIImage(named: "Ace"), isRed: true)
        }
        
        return slot
    }
}