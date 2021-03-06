//
//  FirstViewController.swift
//  THGLocationExample
//
//  Created by Sam Grover on 3/19/15.
//  Copyright (c) 2015 Set Direction. All rights reserved.
//

import UIKit
import THGLocation

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startLocationUpdates()
        
        let listener3: NSObject = NSObject()
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1_000_000_000), dispatch_get_main_queue()) { () -> Void in
            let request = LocationUpdateRequest(accuracy: .Better) { (success, location, error) -> Void in
                if success {
                    print("LISTENER 3: success!!!!")
                } else {
                    if let theError = error {
                        print("LISTENER 3: error is \(theError.localizedDescription)")
                    }
                }
            }
            
            if let requestError = LocationUpdateService().registerListener(listener3, request: request) {
                print("LISTENER 3: error in making request. error is \(requestError.localizedDescription)")
            } else {
                print("LISTENER 3 ADDED")
            }
            
            // Schedule removal after some time seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5_000_000_000), dispatch_get_main_queue()) { () -> Void in
                print("REMOVING LISTENER 3")
                LocationUpdateService().deregisterListener(listener3)
            }
        }
        
        var listener4: NSObject = NSObject()
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1_000_000_000), dispatch_get_main_queue()) { () -> Void in
            let request = LocationUpdateRequest(accuracy: .Best) { (success, location, error) -> Void in
                if success {
                    print("LISTENER 4: success!!!!")
                } else {
                    if let theError = error {
                        print("LISTENER 4: error is \(theError.localizedDescription)")
                    }
                }
            }
            
            if let requestError = LocationUpdateService().registerListener(listener4, request: request) {
                print("LISTENER 4: error in making request. error is \(requestError.localizedDescription)")
            } else {
                print("LISTENER 4 ADDED")
            }
            
            // Schedule removal after some time seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10_000_000_000), dispatch_get_main_queue()) { () -> Void in
                print("LETTING LISTENER 4 BE DEALLOCED")
                listener4 = NSObject()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startLocationUpdates() {
        let request = LocationUpdateRequest(accuracy: .Good) { (success, location, error) -> Void in
            if success {
                print("LISTENER 2: success!!!!")
            } else {
                if let theError = error {
                    print("LISTENER 2: error is \(theError.localizedDescription)")
                }
            }
        }
        
        if let requestError = LocationUpdateService().registerListener(self, request: request) {
            print("LISTENER 2: error in making request. error is \(requestError.localizedDescription)")
        } else {
            print("LISTENER 2 ADDED")
        }
        
        // Schedule removal after some time seconds
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 15_000_000_000), dispatch_get_main_queue()) { () -> Void in
            print("REMOVING LISTENER 2")
            LocationUpdateService().deregisterListener(self)
        }
    }    

}

