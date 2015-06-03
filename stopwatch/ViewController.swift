//
//  ViewController.swift
//  stopwatch
//
//  Created by Blaed on 4/27/15.
//  Copyright (c) 2015 blaed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!

    var timer = NSTimer()
    var counter = 0
    
    func updateTime() {
        counter++
        timeLabel.text = "\(counter)"
    }
    
    @IBAction func pause(sender: AnyObject) {
        timer.invalidate()
    }
 
    @IBAction func play(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTime"), userInfo:nil, repeats: true)
    }

    
    @IBAction func stop(sender: AnyObject) {
        timer.invalidate()
        counter = 0
        timeLabel.text = "0.0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

