//
//  ViewController.swift
//  stopwatch
//
//  Created by Blaed on 4/27/15.
//  Copyright (c) 2015 blaed. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var toolbar: UIToolbar!
   
    @IBOutlet weak var lapsTable: UITableView!
 
    var timer = NSTimer()
    var counter = 0.0
    var playPauseButton = UIBarButtonItem()
    var clearButton = UIBarButtonItem()
    var flexSpacer = UIBarButtonItem()
    var laps = [Int: Double]()
    func updateTime() {
        counter = round((counter + 0.1) * 10) / 10
        print(counter)
        print("\n")
        timeLabel.text = "\(counter)"
    }
    
    func toggleOnOff() {

        if(!timer.valid) {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateTime"), userInfo:nil, repeats: true)
            togglePlayPauseButton(UIBarButtonSystemItem.Pause)
        } else {
            timer.invalidate()
            togglePlayPauseButton(UIBarButtonSystemItem.Play)
        }
    }

    
    func togglePlayPauseButton(style: UIBarButtonSystemItem){
        playPauseButton = UIBarButtonItem(barButtonSystemItem: style, target: self, action: Selector("toggleOnOff"))
        var buttons = [playPauseButton, flexSpacer, clearButton]
        toolbar.setItems(buttons, animated: false)
    }
    
    func stop() {
        if timer.valid {
            timer.invalidate()
            togglePlayPauseButton(UIBarButtonSystemItem.Play)
        }
        laps[laps.count + 1] = counter
        counter = 0
        timeLabel.text = "0.0"
        lapsTable.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        var lapText = "Lap "
        lapText += String(indexPath.row + 1)
        lapText += ": "
        lapText += String(stringInterpolationSegment: laps[indexPath.row + 1]!)
        lapText += " seconds"
        cell.textLabel?.text = lapText
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playPauseButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: Selector("toggleOnOff"))
        clearButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: Selector("stop"))
        flexSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        var buttons = [playPauseButton, flexSpacer, clearButton]
        toolbar.setItems(buttons, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

