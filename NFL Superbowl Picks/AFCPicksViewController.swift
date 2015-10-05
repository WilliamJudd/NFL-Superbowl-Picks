//
//  AFCPicksViewController.swift
//  NFL Picks
//
//  Created by William Judd on 9/29/15.
//  Copyright © 2015 William Judd. All rights reserved.
//

import UIKit
import Firebase
import Foundation
import AssetsLibrary
import MessageUI
import AVFoundation

class AFCPicksViewController: UIViewController {
    
    // Bubble Animation
    
    var bubbleSound: SystemSoundID!
    let defaultDuration = 2.0
    let defaultDamping = 0.20
    let defaultVelocity = 6.0
    
    // Firebase
    
    var recordRef: Firebase!
    var toRecipient: String!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // Progress Indicator
    
    
    var currentCount = 0.0
    let maxCount = 5.0
    
    
    // Dynamics
    
    var animator: UIDynamicAnimator!
    var collisionBehavior: UICollisionBehavior!
    var pushBehavior: UIPushBehavior!
    var pushBehavior2: UIPushBehavior!
    var itemBehavior: UIDynamicItemBehavior!
    var gravity: UIGravityBehavior!
    
    // Alert View
    var overlayView: UIView!
    var alertView: UIView!
    var attachmentBehavior : UIAttachmentBehavior!
    var snapBehavior : UISnapBehavior!
   
    
    @IBOutlet weak var circularProgressView: KDCircularProgress!
    @IBOutlet weak var jaguars: UIButton!
    @IBOutlet weak var titans: UIButton!
    @IBOutlet weak var texans: UIButton!
    @IBOutlet weak var ravens: UIButton!
    @IBOutlet weak var raiders: UIButton!
    @IBOutlet weak var patriots: UIButton!
    @IBOutlet weak var dolphins: UIButton!
    @IBOutlet weak var colts: UIButton!
    @IBOutlet weak var cheifs: UIButton!
    @IBOutlet weak var chargers: UIButton!
    @IBOutlet weak var browns: UIButton!
    @IBOutlet weak var broncos: UIButton!
    @IBOutlet weak var bills: UIButton!
    @IBOutlet weak var steelers: UIButton!
    @IBOutlet weak var jets: UIButton!
    @IBOutlet weak var bengals: UIButton!
    @IBOutlet weak var afcLogo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animator = UIDynamicAnimator(referenceView: self.view)
        circularProgressView.angle = 0
        createOverlay()
        createAlert()
        
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        let bubbles = [self.jaguars,self.titans,self.texans,self.ravens,self.raiders,self.patriots,self.dolphins,self.colts,self.cheifs,self.chargers,self.browns,self.broncos,self.bills,self.steelers,self.jets,self.bengals]
        
        for bt in bubbles{
            
            // Circle move
            let pathAnimation = CAKeyframeAnimation(keyPath: "position")
            pathAnimation.calculationMode = kCAAnimationPaced
            pathAnimation.fillMode = kCAFillModeForwards
            pathAnimation.removedOnCompletion = false
            pathAnimation.repeatCount = Float.infinity
            pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            
            if (bt == self.jaguars) {
                pathAnimation.duration = 5.0
            }else if (bt == self.titans){
                pathAnimation.duration = 6.0
            }else if (bt == self.texans){
                pathAnimation.duration = 7.0
            }else if (bt == self.ravens){
                pathAnimation.duration = 8.0
            }else if (bt == self.raiders){
                pathAnimation.duration = 6.0
            }else if (bt == self.patriots){
                pathAnimation.duration = 7.0
            }else if (bt == self.dolphins){
                pathAnimation.duration = 8.0
            }else if (bt == self.colts){
                pathAnimation.duration = 6.0
            }else if (bt == self.cheifs){
                pathAnimation.duration = 7.0
            }else if (bt == self.chargers){
                pathAnimation.duration = 8.0
            }else if (bt == self.browns){
                pathAnimation.duration = 6.0
            }else if (bt == self.broncos){
                pathAnimation.duration = 7.0
            }else if (bt == self.bills){
                pathAnimation.duration = 8.0
            }else if (bt == self.steelers){
                pathAnimation.duration = 6.0
            }else if (bt == self.jets){
                pathAnimation.duration = 7.0
            }else if (bt == self.bengals){
                pathAnimation.duration = 8.0
            }
            
            
            let curvedPath = CGPathCreateMutable()
            let circleContainer = CGRectInset(bt.frame, bt.frame.size.width/2-3, bt.frame.size.width/2-3)
            CGPathAddEllipseInRect(curvedPath, nil, circleContainer)
            pathAnimation.path = curvedPath
            bt.layer.addAnimation(pathAnimation, forKey: "myCircleAnimation")
            
            
            // scale in X
            let scaleX = CAKeyframeAnimation(keyPath:"transform.scale.x")
            scaleX.values   =  [1.0, 1.1, 1.0]
            scaleX.keyTimes =  [0.0, 0.5,1.0]
            scaleX.repeatCount = Float.infinity
            scaleX.autoreverses = true
            scaleX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            
            if (bt == self.jaguars) {
                scaleX.duration = 3
            }else if (bt == self.titans){
                scaleX.duration = 4
            }else if (bt == self.texans){
                scaleX.duration = 6
            }else if (bt == self.ravens){
                scaleX.duration = 5
            }else if (bt == self.raiders){
                scaleX.duration = 4
            }else if (bt == self.patriots){
                scaleX.duration = 6
            }else if (bt == self.dolphins){
                scaleX.duration = 5
            }else if (bt == self.colts){
                scaleX.duration = 4
            }else if (bt == self.cheifs){
                scaleX.duration = 6
            }else if (bt == self.chargers){
                scaleX.duration = 5
            }else if (bt == self.browns){
                scaleX.duration = 4
            }else if (bt == self.broncos){
                scaleX.duration = 6
            }else if (bt == self.bills){
                scaleX.duration = 5
            }else if (bt == self.steelers){
                scaleX.duration = 4
            }else if (bt == self.jets){
                scaleX.duration = 6
            }else if (bt == self.bengals){
                scaleX.duration = 5
            }
            
            
            
            bt.layer.addAnimation(scaleX, forKey: "scaleXAnimation")
            
            
            
            //2.Y方向上的缩放 scale in Y
            let scaleY = CAKeyframeAnimation(keyPath:"transform.scale.y")
            scaleY.values = [1.0, 1.1, 1.0]
            scaleY.keyTimes = [0.0, 0.5,1.0]
            scaleY.repeatCount = Float.infinity
            scaleY.autoreverses = true
            scaleX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            if (bt == self.jaguars) {
                scaleY.duration = 3
            }else if (bt == self.titans){
                scaleY.duration = 4
            }else if (bt == self.texans){
                scaleY.duration = 6
            }else if (bt == self.ravens){
                scaleY.duration = 5
            }else if (bt == self.raiders){
                scaleY.duration = 4
            }else if (bt == self.patriots){
                scaleY.duration = 6
            }else if (bt == self.dolphins){
                scaleY.duration = 5
            }else if (bt == self.colts){
                scaleY.duration = 4
            }else if (bt == self.cheifs){
                scaleY.duration = 6
            }else if (bt == self.chargers){
                scaleY.duration = 5
            }else if (bt == self.browns){
                scaleY.duration = 4
            }else if (bt == self.broncos){
                scaleY.duration = 6
            }else if (bt == self.bills){
                scaleY.duration = 5
            }else if (bt == self.steelers){
                scaleY.duration = 4
            }else if (bt == self.jets){
                scaleY.duration = 6
            }else if (bt == self.bengals){
                scaleY.duration = 5
            }
            
            bt.layer.addAnimation(scaleY, forKey: "scaleYAnimation")
        }

    }
    
    func createOverlay() {
        // Create a gray view and set its alpha to 0 so it isn't visible
        overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = UIColor.grayColor()
        overlayView.alpha = 0.0
        view.addSubview(overlayView)
    }
    
    func createAlert() {
        // Here the red alert view is created. It is created with rounded corners and given a shadow around it
        let alertWidth: CGFloat = 450
        let alertHeight: CGFloat = 375
        let alertViewFrame: CGRect = CGRectMake(0, 0, alertWidth, alertHeight)
        alertView = UIView(frame: alertViewFrame)
        alertView.backgroundColor = UIColor.redColor()
        alertView.alpha = 0.0
        alertView.layer.cornerRadius = 10;
        alertView.layer.shadowColor = UIColor.blackColor().CGColor;
        alertView.layer.shadowOffset = CGSizeMake(0, 5);
        alertView.layer.shadowOpacity = 0.3;
        alertView.layer.shadowRadius = 10.0;
        
        // Create a button and set a listener on it for when it is tapped. Then the button is added to the alert view
        let button = UIButton(type: UIButtonType.System) as UIButton
        button.setTitle("Dismiss", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.whiteColor()
        
        button.frame = CGRectMake(0, 0, alertWidth, 40.0)
        button.layer.cornerRadius = 2
        button.addTarget(self, action: Selector("dismissAlert"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let button2 = UIButton(type: UIButtonType.System) as UIButton
        button2.setTitle("Pick AFC", forState: UIControlState.Normal)
        button2.backgroundColor = UIColor.whiteColor()
        button2.addTarget(self, action: Selector("afcPicks"), forControlEvents: UIControlEvents.TouchUpInside)
        button2.frame = CGRectMake(0, 135, alertWidth, 40.0)
        button2.layer.cornerRadius = 2
        button2
        alertView.addSubview(button)
        alertView.addSubview(button2)
        view.addSubview(alertView)
    }
    
    
    
    
    
    func showAlert() {
        // When the alert view is dismissed, I destroy it, so I check for this condition here
        // since if the Show Alert button is tapped again after dismissing, alertView will be nil
        // and so should be created again
        if (alertView == nil) {
            createAlert()
        }
        
        
        
        animator.removeAllBehaviors()
        
        // Animate in the overlay
        UIView.animateWithDuration(0.4) {
            self.overlayView.alpha = 1.0
        }
        
        // Animate the alert view using UIKit Dynamics.
        alertView.alpha = 1.0
        
        let snapBehaviour: UISnapBehavior = UISnapBehavior(item: alertView, snapToPoint: view.center)
        animator.addBehavior(snapBehaviour)
    }
    
    
    
    func afcPicks () {
        
        performSegueWithIdentifier("afcpicks", sender: self)
        
    }
    
    
    
    
    
    func dismissAlert() {
        
        animator.removeAllBehaviors()
        
        let gravityBehaviour: UIGravityBehavior = UIGravityBehavior(items: [alertView])
        gravityBehaviour.gravityDirection = CGVectorMake(0.0, 10.0);
        animator.addBehavior(gravityBehaviour)
        
        // This behaviour is included so that the alert view tilts when it falls, otherwise it will go straight down
        let itemBehaviour: UIDynamicItemBehavior = UIDynamicItemBehavior(items: [alertView])
        itemBehaviour.addAngularVelocity(CGFloat(-M_PI_2), forItem: alertView)
        animator.addBehavior(itemBehaviour)
        
        // Animate out the overlay, remove the alert view from its superview and set it to nil
        // If you don't set it to nil, it keeps falling off the screen and when Show Alert button is
        // tapped again, it will snap into view from below. It won't have the location settings we defined in createAlert()
        // And the more it 'falls' off the screen, the longer it takes to come back into view, so when the Show Alert button
        // is tapped again after a considerable time passes, the app seems unresponsive for a bit of time as the alert view
        // comes back up to the screen
        UIView.animateWithDuration(0.4, animations: {
            self.overlayView.alpha = 0.0
            }, completion: {
                (value: Bool) in
                self.alertView.removeFromSuperview()
                self.alertView = nil
        })
        
    }
    
    
    
    
    
    @IBAction func teamProgressButtonTapped(sender: UIButton) {
        if currentCount < 4 {
            currentCount += 1
            let newAngleValue = newAngle()
            
            circularProgressView.animateToAngle(newAngleValue, duration: 0.5, completion: nil)
            
            
        }else{
            
            showAlert()
            
        }
    }
    
    func newAngle() -> Int {
        return Int(360 * (currentCount / maxCount))
    }
    
    //    @IBAction func resetButtonTapped(sender: UIButton) {
    //        currentCount = 0
    //        circularProgressView.animateFromAngle(circularProgressView.angle, toAngle: 0, duration: 0.5, completion: nil)
    //    }
    
}



