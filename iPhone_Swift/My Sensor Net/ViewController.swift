//
//  ViewController.swift
//  My Sensor Net
//
//  Created by Ryan Pasecky on 4/30/17.
//  Copyright © 2017 Ryan Pasecky. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var ref: DatabaseReference!
    var visualEffectView: UIVisualEffectView?
    var LED_On : String?
    var currentlyTouching : String?
    
    
    @IBOutlet var LED_Label: UILabel!
    @IBOutlet var currentlyTouching_Label: UILabel!
    @IBOutlet var totalExposureView: UIVisualEffectView!
    @IBOutlet var buttonHorizontalOffset: NSLayoutConstraint!
    @IBOutlet var toggleSwitchButton: UIButton!
    @IBAction func toggleSwitch(_ sender: Any) {
        toggleSwitch()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        observeData()
    }
    
    
    func observeData() {
        ref.observe(.value, with: { snapshot in
            let returnedKey = String()
            let returnedValue = String()
            print("key: \(returnedKey) value: \(returnedValue)")
            
            for item0 in snapshot.children {
                let child0 = item0 as! DataSnapshot
                for item1 in child0.children {
                    let child1 = item1 as! DataSnapshot
                    
                    if child1.key == "currentlyTouching" {
                        self.currentlyTouching = String(describing: child1.value!)
                    }
                    
                    if child1.key == "switch" {
                        self.LED_On = String(describing: child1.value!)
                    }
                    
                }
            }
            
            if self.LED_On == nil {
                self.ref.child("light").child("switch").setValue("off")
            }
            
            if self.currentlyTouching == nil {
                self.ref.child("touch").child("currentlyTouching").setValue("false")
            }
            
            self.LED_Label.text = self.LED_On
            self.currentlyTouching_Label.text = self.currentlyTouching
        })
    }
    
    func toggleSwitch() {
        
        if let currentReading = LED_On {
            if currentReading == "off" {   // This could be any type of data
                self.ref.child("light").child("switch").setValue("on")
                //didGoOutsideButton.titleLabel?.text = "on"
            } else if currentReading == "on" {
                self.ref.child("light").child("switch").setValue("off")
            }
        }
    }
    
}


