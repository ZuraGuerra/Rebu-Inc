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
        
        
        var timer = NSTimer()
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("carsNearMe"), userInfo: nil, repeats: true)
    }
    
    func carsNearMe() {
        let point = PFGeoPoint(latitude:19.430662, longitude:-99.200996)
        /*
        var query = PFQuery(className:"_User")
        query.whereKey("location", nearGeoPoint:point)
        query.whereKey("driver", equalTo: true)
        query.limit = 10
        
        var placesObjects = query.findObjects()
        println(placesObjects)
        */
        
        var query = PFQuery(className:"_User")
        query.whereKey("location", nearGeoPoint:point)
        query.whereKey("driver", equalTo: true)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) drivers.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        
                        var username: AnyObject! = object.objectForKey("username")
                        var location: PFGeoPoint = object.objectForKey("location") as PFGeoPoint
                        
                        println("Driver: \(username)")
                        println("Latitude: \(location.latitude) Longitude: \(location.longitude)")
                    }
                    // println(objects[0].objectForKey("location"))
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

