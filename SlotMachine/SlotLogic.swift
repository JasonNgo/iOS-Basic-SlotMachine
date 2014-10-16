//
//  SlotLogic.swift
//  SlotMachine
//
//  Created by Jason Ngo on 2014-10-15.
//  Copyright (c) 2014 Jason Ngo. All rights reserved.
//

import Foundation

class SlotLogic {
    class func unpackSlotsIntoRows (slots: [[Slot]]) -> [[Slot]] {
        var SlotRow1:[Slot] = []
        var SlotRow2:[Slot] = []
        var SlotRow3:[Slot] = []
        
        for slotArray in slots {
            for (var index = 0; index < slotArray.count; index++) {
                let slot = slotArray[index]
                if (index == 0) {
                    SlotRow1.append(slot)
                } else if (index == 1) {
                    SlotRow2.append(slot)
                } else if (index == 2) {
                    SlotRow3.append(slot)
                } else {
                    println("An error has occured")
                }
            }
        }
        var slotsInRows:[[Slot]] = [SlotRow1, SlotRow2, SlotRow3]
        return slotsInRows
    }
    
    class func calculateWinnings (slots: [[Slot]]) -> Int {
        var slotsInRows = unpackSlotsIntoRows(slots)
        var winnings = 0
        var flushCount = 0
        var threeInARowCount = 0
        var threeOfAKindCount = 0
        
        for slotRow in slotsInRows {
            if (checkFlush(slotRow) == true) {
                println("Flush")
                winnings += 1
                flushCount += 1
            }
            
            if (checkThreeInARow(slotRow) == true) {
                println("Three of a kind")
                winnings += 1
                threeInARowCount += 1
            }
            
            if (checkThreeOfAKind(slotRow) == true) {
                println("Three of a kind")
                winnings += 3
                threeOfAKindCount += 1
            }
        }
        
        if (flushCount == 3) {
            println("Royal Flush")
            winnings += 12
        }
        
        if (threeInARowCount == 3) {
            println("Epic straight")
            winnings += 997
        }
        
        if (threeOfAKindCount == 3) {
            println("Three's all around")
            winnings += 50
        }
        return winnings
    }
    
    class func checkFlush (slotRow:[Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if (slot1.isRed == true && slot2.isRed == true && slot3.isRed == true) ||
            (slot1.isRed == false && slot2.isRed == false && slot3.isRed == false) {
            return true
        } else {
            return false
        }
    }
    
    class func checkThreeInARow (slotRow:[Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if ((slot1.number == slot2.number + 1) && (slot1.number == slot3.number + 2)) ||
            ((slot1.number == slot2.number - 1) && (slot1.number == slot3.number - 2)) {
            return true
        } else {
            return false
        }
    }
    
    class func checkThreeOfAKind (slotRow:[Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if (slot1.number == slot2.number) && (slot1.number == slot3.number) {
            return true
        } else {
            return false
        }
    }
}