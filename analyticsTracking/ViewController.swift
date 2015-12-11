//
//  ViewController.swift
//  analyticsTracking
//
//  Created by Zachary on 4/15/15.
//  Copyright (c) 2015 test. All rights reserved.
//


import UIKit

private var buttonStatistics = [Int: Int]()
func address<T: AnyObject>(o: T) -> Int {
    return unsafeBitCast(o, Int.self)
}


extension UIButton {
    // Extensions cannot add properties, so instead of:
    //var numberOfClicks: Int = 0
    // We use associated objects
    public var numberOfClicks : Int {
        get
        {
            return buttonStatistics[address(self)]!
        }
        
        set
        {
            buttonStatistics[address(self)]! = newValue
        }
    }
    
    func resister() {
        buttonStatistics[address(self)] = 0
    }
    
    func reportStatistics() {
        print("Button stats: ")
        println("This button has been clicked \(self.numberOfClicks) times.")
    }
    
    public override func sendAction(action: Selector, to target: AnyObject?, forEvent event: UIEvent?) {
        // Record statistic here
        self.numberOfClicks += 1
        super.sendAction(action, to: target, forEvent: event)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var buttonA: UIButton!
    @IBOutlet var buttonB: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // If you want a view to be tracked, you have to register it
        buttonA.resister()
        buttonB.resister()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTapped(sender: AnyObject) {
        
        
        if let button = sender as? UIButton {
            button.reportStatistics()
        }
    }
    
}

