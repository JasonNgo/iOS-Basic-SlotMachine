//
//  ViewController.swift
//  SlotMachine
//
//  Created by Jason Ngo on 2014-10-08.
//  Copyright (c) 2014 Jason Ngo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Containers
    var firstContainer:UIView!
    var secondContainer:UIView!
    var thirdContainer:UIView!
    var fourthContainer:UIView!
    var fifthContainer:UIView!
    
    // Labels
    var lblTitle:UILabel!
    var lblCredits:UILabel!
    var lblBet:UILabel!
    var lblWinner:UILabel!
    var lblCreditsTitle:UILabel!
    var lblBetTitle:UILabel!
    var lblWinnerPaidTitle:UILabel!
    
    // IBOutlets
    var credits = 0
    var currentBet = 0
    var winnings = 0
    
    // Buttons
    var btnReset:UIButton!
    var btnBetOne:UIButton!
    var btnBetMax:UIButton!
    var btnSpin:UIButton!
    
    // Constants
    let kMarginForView:CGFloat = 10.0
    let kSixth:CGFloat = 1.0 / 6.0
    let kNumberOfContainers = 3
    let kNumberOfSlots = 3
    let kThird:CGFloat = 1.0 / 3.0
    let kMarginForSlot:CGFloat = 2.0
    let kHalf:CGFloat = 1.0 / 2.0
    let kEighth:CGFloat = 1.0 / 8.0
    
    var fourthContainerLabels:[UILabel] = []
    var fourthContainerLabelTitles:[UILabel] = []
    var slots:[[Slot]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainerViews()
        hardReset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // IBActions
    func btnResetPressed (button:UIButton) {
        hardReset()
    }
    
    func btnBetOnePressed (button:UIButton) {
        if (credits <= 0) {
            showAlerts(header: "No Credits Remaining", message: "Please reset the game")
        } else {
            if currentBet < 5 {
                currentBet += 1
                credits -= 1
                updateValues()
            } else {
                showAlerts(message: "The maximum bet you can make is 5")
            }
        }
    }
    
    func btnBetMaxPressed (button:UIButton) {
        if (credits <= 5) {
            showAlerts(header: "Not Enough Credits", message: "Please bet a lower amount")
        } else {
            if (currentBet < 5) {
                var maximumBet:Int = 5 - currentBet
                credits -= maximumBet
                currentBet += maximumBet
                updateValues()
            } else {
                showAlerts(message: "The maximum bet you can make is 5")
            }
        }
    }
    
    func btnSpinPressed(button:UIButton) {
        removeSlotImages()
        slots = Factory.createSlots()
        setupThirdContainer(self.thirdContainer)
        
        var winningsMultiplier = SlotLogic.calculateWinnings(slots)
        winnings = winningsMultiplier * currentBet
        credits += winnings
        currentBet = 0
        updateValues()
    }
    
    func setupContainerViews() {
        self.firstContainer = UIView(frame: CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.width, self.view.bounds.height))
        self.firstContainer.backgroundColor = UIColor.darkGrayColor()
        self.view.addSubview(self.firstContainer)
        
        self.secondContainer = UIView(frame: CGRectMake(self.view.bounds.origin.x + kMarginForView, self.view.bounds.origin.y, self.view.bounds.width - (kMarginForView * 2), (self.view.bounds.height * kSixth)))
        self.secondContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.secondContainer)
        
        self.thirdContainer = UIView(frame: CGRectMake(self.view.bounds.origin.x + kMarginForView, self.secondContainer.frame.height, self.view.bounds.width - (kMarginForView * 2), self.view.bounds.height * (kSixth * 3)))
        self.thirdContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.thirdContainer)
        
        self.fourthContainer = UIView(frame: CGRectMake(self.view.bounds.origin.x + kMarginForView, self.secondContainer.frame.height + self.thirdContainer.frame.height, self.view.bounds.width - (kMarginForView * 2), (self.view.bounds.height * kSixth)))
        self.fourthContainer.backgroundColor = UIColor.grayColor()
        self.view.addSubview(self.fourthContainer)
        
        self.fifthContainer = UIView(frame: CGRectMake(self.view.bounds.origin.x + kMarginForView, self.secondContainer.frame.height + self.thirdContainer.frame.height + self.fourthContainer.frame.height, self.view.bounds.width - (kMarginForView * 2), (self.view.bounds.height * kSixth)))
        self.fifthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.fifthContainer)
        
        setupSecondContainer(secondContainer)
        setupThirdContainer(thirdContainer)
        setupFourthContainer(fourthContainer)
        setupFifthContainer(fifthContainer)
    }
    
    func setupSecondContainer(containerView:UIView) {
        self.lblTitle = UILabel()
        self.lblTitle.text = "Super Slots"
        self.lblTitle.textColor = UIColor.yellowColor()
        self.lblTitle.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.lblTitle.sizeToFit()
        self.lblTitle.center = containerView.center
        containerView.addSubview(self.lblTitle)
    }
    
    func setupThirdContainer(containerView:UIView) {
        for (var containerNumber = 0; containerNumber < kNumberOfContainers; containerNumber++) {
            for (var slotNumber = 0; slotNumber < kNumberOfSlots; slotNumber++) {
                
                var slotImageView = UIImageView()
                var slot:Slot
                
                if slots.count != 0 {
                    let slotContainer = slots[containerNumber]
                    slot = slotContainer[slotNumber]
                    slotImageView.image = slot.image
                } else {
                    slotImageView.image = UIImage(named: "Ace")
                }
                
                slotImageView.backgroundColor = UIColor.yellowColor()
                slotImageView.frame = CGRect(x: containerView.bounds.origin.x + containerView.bounds.size.width * CGFloat(containerNumber) / CGFloat(kNumberOfContainers), y: containerView.bounds.origin.y + containerView.bounds.size.height * CGFloat(slotNumber) / CGFloat(kNumberOfSlots), width: containerView.bounds.width * kThird - kMarginForSlot, height: containerView.bounds.height * kThird - kMarginForSlot)
                containerView.addSubview(slotImageView)
            }
        }
    }
    
    func setupFourthContainer(containerView:UIView) {
        lblCredits = UILabel()
        lblCreditsTitle = UILabel()
        lblBet = UILabel()
        lblBetTitle = UILabel()
        lblWinner = UILabel()
        lblWinnerPaidTitle = UILabel()
        
        fourthContainerLabels += [lblCredits, lblBet, lblWinner]
        fourthContainerLabelTitles += [lblCreditsTitle, lblBetTitle, lblWinnerPaidTitle]
        
        for (var i = 0; i < 3; i++) {
            setupFourthContainerTitles(fourthContainer, contTitle: fourthContainerLabelTitles[i], position: i)
        }
        
        for (var j = 0; j < 3; j++) {
            setupFourthContainerLabels(fourthContainer, contLabel: fourthContainerLabels[j], position: j)
        }
    }
    
    func setupFourthContainerLabels(containerView:UIView, contLabel:UILabel, position:Int) {
        contLabel.text = "000000"
        contLabel.textColor = UIColor.redColor()
        contLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        contLabel.sizeToFit()
        contLabel.center = CGPoint(x: containerView.frame.size.width * kSixth * CGFloat((position * 2) + 1), y: containerView.frame.size.height * kThird * 2)
        contLabel.textAlignment = NSTextAlignment.Center
        contLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(contLabel)
    }
    
    func setupFourthContainerTitles(containerView:UIView, contTitle:UILabel, position:Int) {
        switch position {
        case 0:
            contTitle.text = "Credits"
        case 1:
            contTitle.text = "Bet"
        case 2:
            contTitle.text = "Winnings"
        default:
            contTitle.text = "Default"
        }
        contTitle.textColor = UIColor.blackColor()
        contTitle.font = UIFont(name: "AmericanTypewriter", size: 16)
        contTitle.sizeToFit()
        contTitle.center = CGPoint(x: containerView.frame.size.width * kSixth * CGFloat((position * 2) + 1), y: containerView.frame.size.height * kThird)
        contTitle.textAlignment = NSTextAlignment.Center
        containerView.addSubview(contTitle)
    }
    
    func setupFifthContainer(containerView:UIView) {
        self.btnReset = UIButton()
        self.btnReset.setTitle("Reset", forState: UIControlState.Normal)
        self.btnReset.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.btnReset.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.btnReset.backgroundColor = UIColor.lightGrayColor()
        self.btnReset.sizeToFit()
        self.btnReset.center = CGPoint(x: containerView.frame.size.width * kEighth, y: containerView.frame.size.height * kHalf)
        self.btnReset.addTarget(self, action: "btnResetPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(btnReset)
        
        self.btnBetOne = UIButton()
        self.btnBetOne.setTitle("Bet One", forState: UIControlState.Normal)
        self.btnBetOne.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.btnBetOne.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.btnBetOne.backgroundColor = UIColor.greenColor()
        self.btnBetOne.sizeToFit()
        self.btnBetOne.center = CGPoint(x: containerView.frame.size.width * kEighth * 3, y: containerView.frame.height * kHalf)
        self.btnBetOne.addTarget(self, action: "btnBetOnePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(btnBetOne)
        
        self.btnBetMax = UIButton()
        self.btnBetMax.setTitle("Bet Max", forState: UIControlState.Normal)
        self.btnBetMax.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.btnBetMax.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.btnBetMax.backgroundColor = UIColor.redColor()
        self.btnBetMax.sizeToFit()
        self.btnBetMax.center = CGPoint(x: containerView.frame.size.width * kEighth * 5, y: containerView.frame.height * kHalf)
        self.btnBetMax.addTarget(self, action: "btnBetMaxPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(btnBetMax)
        
        self.btnSpin = UIButton()
        self.btnSpin.setTitle("Spin", forState: UIControlState.Normal)
        self.btnSpin.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.btnSpin.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.btnSpin.backgroundColor = UIColor.greenColor()
        self.btnSpin.sizeToFit()
        self.btnSpin.center = CGPoint(x: containerView.frame.size.width * kEighth * 7, y: containerView.frame.height * kHalf)
        self.btnSpin.addTarget(self, action: "btnSpinPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(btnSpin)
    }
    
    func removeSlotImages() {
        if (self.thirdContainer != nil) {
            let container:UIView? = self.thirdContainer
            let subViews:Array? = container!.subviews
            for view in subViews! {
                view.removeFromSuperview()
            }
        }
    }
    
    func hardReset() {
        removeSlotImages()
        slots.removeAll(keepCapacity: true)
        self.setupThirdContainer(self.thirdContainer)
        credits = 50
        winnings = 0
        currentBet = 0
        updateValues()
    }

    func updateValues() {
        self.lblCredits.text = "\(credits)"
        self.lblBet.text = "\(currentBet)"
        self.lblWinner.text = "\(winnings)"
    }
    
    func showAlerts(header: String = "Warning", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

