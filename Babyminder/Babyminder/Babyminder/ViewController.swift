//
//  ViewController.swift
//  Babyminder
//
//  Created by Dave Taylor on 10/20/18.
//  Copyright © 2018 Dave Taylor. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let activityManager = CMMotionActivity()
   
    var inTransit: Bool = false
    
    // Given how the travellingIndicator UILabel is setup,
    // I'm guessing that these switches from the settings
    // aren't setup correctly
    var alwaysOnTracking: Bool = false
    var pauseTracking: Bool = false
    
    
    
    @IBOutlet weak var travellingIndicator: UILabel!

    
    
    func carCheck(activityManager: CMMotionActivity!, inTransit: inout Bool)
    {
        if (activityManager.automotive)
        {
            if (!inTransit)
            {
                inTransit = true
                // I hope this is right. I'm not sure
                travellingIndicator.text = "Travelling"
            }
        }
        else
        {
            if (inTransit)
            {
                inTransit = false
                // send push notificaitons
                // change the app view to the reminder story board
            }
        }
        
        // Wait 60 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {}
    }
    
    @objc func StartTimePickerChanged(StartTimePicker: UIDatePicker)
    {
        print(StartTimePicker.date)
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        let StartTimePicker = UIDatePicker()
        let StartHour: Int
        let StartMinute: Int
        
        // Get the schedule start time
        StartTimePicker.datePickerMode = .time
        StartTimePicker.addTarget(self, action: #selector(StartTimePickerChanged(StartTimePicker:)), for: .valueChanged)
        let date = StartTimePicker.date
        let StartComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        StartHour = StartComponents.hour!
        StartMinute = StartComponents.minute!
        
        // Get the schedule end time
        
        
        // Get the current time
        
        
        
        while (alwaysOnTracking)
        {
            carCheck(activityManager: activityManager, inTransit: &inTransit)
        }
        
        // Figure out how to compare the current time to the start and end times
        while (/* st <= ct <= et && */ !(pauseTracking || alwaysOnTracking))
        {
            break
            carCheck(activityManager: activityManager, inTransit: &inTransit)
        }
        
        print(StartHour,":",StartMinute)
    }
}

