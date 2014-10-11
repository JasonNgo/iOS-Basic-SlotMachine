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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainerViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
}

