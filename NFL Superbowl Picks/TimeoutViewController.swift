//
//  TimeoutViewController.swift
//  NFL Superbowl Picks
//
//  Created by William Judd on 6/11/15.
//  Copyright © 2015 William Judd. All rights reserved.
//

import UIKit

class TimeoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToContainerVC(segue: UIStoryboardSegue) {
        
    }
    
     
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first {
            performSegueWithIdentifier("login", sender: nil)
        }
        super.touchesBegan(touches, withEvent:event)
    }
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
