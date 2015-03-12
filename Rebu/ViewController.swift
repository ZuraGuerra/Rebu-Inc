//
//  ViewController.swift
//  Rebu
//
//  Created by Zura Guerra on 3/2/15.
//  Copyright (c) 2015 Rebu Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func fbConnect(sender: AnyObject) {
        // log in & sign up
        var permissions = ["email", "public_profile", "user_likes"]
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                NSLog("Uh oh. The user cancelled the Facebook login.")
            } else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")
                
            } else {
                NSLog("User logged in through Facebook!")
                self.performSegueWithIdentifier("MapScreen", sender: self)
            }
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

