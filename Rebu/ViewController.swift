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
                var Register : UINavigationController = self.storyboard!.instantiateViewControllerWithIdentifier("Register") as UINavigationController
                
                self.navigationController!.pushViewController(Register, animated: true)
                
                
            } else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")
                
            } else {
                NSLog("User logged in through Facebook!")
               // self.performSegueWithIdentifier("MapScreen", sender: self)
                
                var MapScreen : UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MapScreen") as UIViewController
                
                self.navigationController!.pushViewController(MapScreen, animated: true)
            }
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // save objects to parse
        var object = PFObject(className: "testDataClass")
        object.addObject("iOSBlog", forKey: "websiteUrl")
        object.addObject("Five", forKey: "websiteRating")
        object.save()
        
        var object2 = PFObject(className: "testDataClass")
        object2.addObject("MEAN book", forKey: "websiteUrl")
        object2.addObject("Four", forKey: "websiteRating")
        object2.save()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

