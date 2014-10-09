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
    
    // Contents
    let kMarginForView:CGFloat = 10.0
    let kSixth:CGFloat = 1.0 / 6.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainerViews()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }


}

