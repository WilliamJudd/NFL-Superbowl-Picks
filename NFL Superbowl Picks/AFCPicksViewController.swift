//
//  AFCPicksViewController.swift
//  NFL Picks
//
//  Created by William Judd on 9/29/15.
//  Copyright © 2015 William Judd. All rights reserved.
//

import UIKit
import Foundation
import AssetsLibrary
import MessageUI
import AVFoundation
import MessageUI
import Firebase


class AFCPicksViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var recordRef: Firebase!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    // Progress Indicator
    var currentCount = 0.0
    let maxCount = 5.0
    // Alert View
    var overlayView: UIView!
    var alertView: UIView!
    // Arrays
    var afcPicks : NSMutableArray = NSMutableArray()
    var afcPicks2 : NSMutableArray = NSMutableArray()
    var nfcPicks : NSMutableArray = NSMutableArray()
    var nfcPicks2 : NSMutableArray = NSMutableArray()
    
    // Timeout
    var timer: NSTimer!
    
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
        circularProgressView.angle = 0
        startTimer()
        createAlert()
        
        
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
    
   
    
    
    func createAlert() {
        
        alertView = UIView(frame: view.bounds)
        alertView.backgroundColor = UIColor.clearColor()
        alertView.alpha = 0.0
        alertView.layer.cornerRadius = 10;
        alertView.layer.shadowColor = UIColor.blackColor().CGColor;
        alertView.layer.shadowOffset = CGSizeMake(0, 5);
        alertView.layer.shadowOpacity = 0.3;
        alertView.layer.shadowRadius = 10.0;
        alertView.tag = 1
        
        
        let alert = UIImage(named: "Alert7") as UIImage!
        let imageView = UIImageView(image: alert)
        imageView.frame = CGRectMake((view.bounds.width - 320) / 2, (view.bounds.height - 280) / 2 - 30, 320, 280)
        imageView.alpha = 0.0
        
        
        
        
        let button = UIButton(type: UIButtonType.System) as UIButton
        button.setTitle("Pick!", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 20)
        button.backgroundColor = UIColor(red: 0.82, green: 0.01, blue: 0.11, alpha: 1)
        button.frame = CGRectMake((view.bounds.width - 310)/2 , (view.bounds.height - 125)/2 + 103, 310, 65)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: Selector("dismissA"), forControlEvents: UIControlEvents.TouchUpInside)
        button.bringSubviewToFront(button)
        
        view.addSubview(alertView)
        alertView.addSubview(imageView)
        alertView.insertSubview(button, aboveSubview: imageView)
        
        UIView.animateWithDuration(0.5) {
            self.alertView.alpha = 1.0
            imageView.alpha = 1.0
         
       
        }
    
    }

        
        
    func createAlert2() {
        
        alertView = UIView(frame: view.bounds)
        alertView.backgroundColor = UIColor.clearColor()
        alertView.alpha = 0.0
        alertView.layer.cornerRadius = 10;
        alertView.layer.shadowColor = UIColor.blackColor().CGColor;
        alertView.layer.shadowOffset = CGSizeMake(0, 5);
        alertView.layer.shadowOpacity = 0.3;
        alertView.layer.shadowRadius = 10.0;
        alertView.tag = 1
        
        let alert = UIImage(named: "Alert4") as UIImage!
        let imageView = UIImageView(image: alert)
        imageView.frame = CGRectMake((view.bounds.width - 320) / 2, (view.bounds.height - 320) / 2 - 30, 320, 320)
        imageView.alpha = 0.0
    
        // Change Picks
        let button = UIButton(type: UIButtonType.System) as UIButton
        button.setTitle("Change Picks", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 20)
        button.backgroundColor = UIColor(red: 0.82, green: 0.01, blue: 0.11, alpha: 1)
        button.frame = CGRectMake((view.bounds.width - 312)/2 , (view.bounds.height - 65)/2 + 26, 312, 65)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: Selector("dismissA"), forControlEvents: UIControlEvents.TouchUpInside)
        button.alpha = 0.9
        
        // Submit
        let button2 = UIButton(type: UIButtonType.System) as UIButton
        button2.setTitle("Submit!", forState: UIControlState.Normal)
        button2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button2.titleLabel?.font = UIFont(name: "Arial", size: 20)
        button2.backgroundColor = UIColor(red: 0.82, green: 0.01, blue: 0.11, alpha: 1)
        button2.frame = CGRectMake((view.bounds.width - 312)/2 , (view.bounds.height - 65)/2 + 94, 312, 65)
        button2.layer.cornerRadius = 5
        button2.alpha = 0.9
        button2.addTarget(self, action: Selector("lastPage"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        view.addSubview(alertView)
        alertView.addSubview(imageView)
        alertView.insertSubview(button, aboveSubview: imageView)
        alertView.insertSubview(button2, aboveSubview: imageView)
        
        UIView.animateWithDuration(0.7) {
            self.alertView.alpha = 1.0
            imageView.alpha = 1.0
//          self.timer.invalidate()
            
        }
    
   
    }
    
    
    func createAlert3() {
       
        alertView = UIView(frame: view.bounds)
        alertView.backgroundColor = UIColor.clearColor()
        alertView.alpha = 0.0
        alertView.layer.cornerRadius = 10;
        alertView.layer.shadowColor = UIColor.blackColor().CGColor;
        alertView.layer.shadowOffset = CGSizeMake(0, 5);
        alertView.layer.shadowOpacity = 0.3;
        alertView.layer.shadowRadius = 10.0;
        alertView.tag = 1
        
        
        let alert = UIImage(named: "Alert5") as UIImage!
        let imageView = UIImageView(image: alert)
        imageView.frame = CGRectMake((view.bounds.width - 320) / 2, (view.bounds.height - 280) / 2 - 30, 320, 280)
        imageView.alpha = 0.0
        
        // OK!
        let button3 = UIButton(type: UIButtonType.System) as UIButton
        button3.setTitle("OK!", forState: UIControlState.Normal)
        button3.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button3.titleLabel?.font = UIFont(name: "Arial", size: 20)
        button3.backgroundColor = UIColor(red: 0.82, green: 0.01, blue: 0.11, alpha: 1)
        button3.frame = CGRectMake((view.bounds.width - 310)/2 , (view.bounds.height - 125)/2 + 103, 310, 65)
        button3.layer.cornerRadius = 5
        button3.addTarget(self, action: Selector("dismissA"), forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(alertView)
        alertView.addSubview(imageView)
        alertView.insertSubview(button3, aboveSubview: imageView)
        
        UIView.animateWithDuration(0.7) {
            self.alertView.alpha = 1.0
            imageView.alpha = 1.0
            
        }
        
    }
   
    func createAlert4() {
        
        alertView = UIView(frame: view.bounds)
        alertView.backgroundColor = UIColor.clearColor()
        alertView.alpha = 0.0
        alertView.layer.cornerRadius = 10;
        alertView.layer.shadowColor = UIColor.blackColor().CGColor;
        alertView.layer.shadowOffset = CGSizeMake(0, 5);
        alertView.layer.shadowOpacity = 0.3;
        alertView.layer.shadowRadius = 10.0;
        alertView.tag = 1
        
        let alert = UIImage(named: "Alert9") as UIImage!
        let imageView = UIImageView(image: alert)
        imageView.frame = CGRectMake((view.bounds.width - 320) / 2, (view.bounds.height - 280) / 2 - 30, 320, 280)
        imageView.alpha = 0.0
        
        // Yes Button
        let button = UIButton(type: UIButtonType.System) as UIButton
        button.setTitle("Yes!", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 20)
        button.backgroundColor = UIColor(red: 0.82, green: 0.01, blue: 0.11, alpha: 1)
        button.frame = CGRectMake((view.bounds.width - 310)/2 , (view.bounds.height - 125)/2 + 103, 310, 65)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: Selector("dismissA"), forControlEvents: UIControlEvents.TouchUpInside)
        button.bringSubviewToFront(button)
        
        view.addSubview(alertView)
        alertView.addSubview(imageView)
        alertView.insertSubview(button, aboveSubview: imageView)
        
        UIView.animateWithDuration(0.7) {
            self.alertView.alpha = 1.0
            imageView.alpha = 1.0
            
            self.timer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: "timeToMoveOn", userInfo: nil, repeats: false)
            
        }
        
    }


func dismissA () {
    
    if let viewWithTag = self.view.viewWithTag(1) {
        viewWithTag.removeFromSuperview()
        resetTimer()
        
    }else{
        
    }
    
}


    @IBAction func teamProgressButtonTapped(sender: UIButton!) {
        
        resetTimer()
        
        titans.setImage(UIImage(named: "titans"), forState:.Normal);
        titans.setImage(UIImage(named: "titansG"), forState:.Selected);
        
        texans.setImage(UIImage(named: "texans"), forState:.Normal);
        texans.setImage(UIImage(named: "texansG"), forState:.Selected);
        
        steelers.setImage(UIImage(named: "steelers"), forState:.Normal);
        steelers.setImage(UIImage(named: "steelersG"), forState:.Selected);
        
        ravens.setImage(UIImage(named: "ravens"), forState:.Normal);
        ravens.setImage(UIImage(named: "ravensG"), forState:.Selected);
        
        raiders.setImage(UIImage(named: "raiders"), forState:.Normal);
        raiders.setImage(UIImage(named: "raidersG"), forState:.Selected);
        
        patriots.setImage(UIImage(named: "patriots"), forState:.Normal);
        patriots.setImage(UIImage(named: "patriotsG"), forState:.Selected);
        
        jets.setImage(UIImage(named: "jets"), forState:.Normal);
        jets.setImage(UIImage(named: "jetsG"), forState:.Selected);
        
        jaguars.setImage(UIImage(named: "jags"), forState:.Normal);
        jaguars.setImage(UIImage(named: "jagsG"), forState:.Selected);
        
        dolphins.setImage(UIImage(named: "dolphins"), forState:.Normal);
        dolphins.setImage(UIImage(named: "dolphinsG"), forState:.Selected);
        
        colts.setImage(UIImage(named: "colts"), forState:.Normal);
        colts.setImage(UIImage(named: "coltsG"), forState:.Selected);
        
        cheifs.setImage(UIImage(named: "cheifs"), forState:.Normal);
        cheifs.setImage(UIImage(named: "cheifsG"), forState:.Selected);
        
        chargers.setImage(UIImage(named: "chargers"), forState:.Normal);
        chargers.setImage(UIImage(named: "chargersG"), forState:.Selected);
        
        browns.setImage(UIImage(named: "browns"), forState:.Normal);
        browns.setImage(UIImage(named: "brownsG"), forState:.Selected);
        
        bills.setImage(UIImage(named: "bills"), forState:.Normal);
        bills.setImage(UIImage(named: "billsG"), forState:.Selected);
        
        bengals.setImage(UIImage(named: "bengals"), forState:.Normal);
        bengals.setImage(UIImage(named: "bengalsG"), forState:.Selected);
        
        broncos.setImage(UIImage(named: "broncos"), forState:.Normal);
        broncos.setImage(UIImage(named: "broncosG"), forState:.Selected);
        
        if sender == sender {
            
            sender.selected = !sender.selected
            
            if sender.state.rawValue == 5  {
                
                
                afcPicks.addObject((sender.titleLabel?.text)!)
                afcPicks2.addObject(sender.imageForState(.Selected)!)
                sender.transform = CGAffineTransformMakeScale(1.3,1.3)
                
            }else{
                
                afcPicks.removeObject((sender.titleLabel?.text)!)
                afcPicks2.removeObject(sender.imageForState(.Selected)!)
                sender.transform = CGAffineTransformMakeScale(1,1)
            }
        }
        
        
        
                let picksRef = recordRef.childByAppendingPath("picks")
        
                let AFCPicks = afcPicks
        
                picksRef.updateChildValues(["afcPicks" : AFCPicks])
        
        if afcPicks.count == (0) {
            
            
            circularProgressView.animateToAngle(0, duration: 0.0, completion: nil)
            
            
        }else{
            
            if afcPicks.count == (1) {
                
                
                circularProgressView.animateToAngle(72, duration: 0.0, completion: nil)
                
                
            }else{
                
                if afcPicks.count == (2) {
                    
                    
                    circularProgressView.animateToAngle(144, duration: 0.0, completion: nil)
                    
                    
                }else{
                    
                    if afcPicks.count == (3) {
                        
                        circularProgressView.animateToAngle(216, duration: 0.0, completion: nil)
                        
                        
                    }else{
                        
                        
                        if afcPicks.count == (4) {
                            
                            
                            circularProgressView.animateToAngle(288, duration: 0.0, completion: nil)
                            
                            
                        }else{
                            
                            if afcPicks.count == (5) {
                                createAlert2()
                                
                                circularProgressView.animateToAngle(360, duration: 0.0, completion: nil)
                                
                            }else{
                                
                                
                                if afcPicks.count == (6){
                                    createAlert3()
                                    sender.selected = !sender.selected
                                    afcPicks.removeLastObject()
                                    afcPicks2.removeLastObject()
                                    circularProgressView.animateToAngle(360, duration: 0.0, completion: nil)
                                }else{
                                    
                                    
                            }
                        }
                    }
                }
            }
        }
    }
}
    
    func newAngle() -> Int {
        
        return Int(360 * (currentCount/maxCount))
        
        
        
    }
    
    func lastPage(){
        
        performSegueWithIdentifier("thanks", sender: self)
        timer.invalidate()
    
    }
  
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "thanks" {
            let thanksViewController = segue.destinationViewController as! PickVerificationViewController
            thanksViewController.recordRef = recordRef
            thanksViewController.nfcPicks = nfcPicks
            thanksViewController.nfcPicks2 = nfcPicks2
            thanksViewController.afcPicks = afcPicks
            thanksViewController.afcPicks2 = afcPicks2
            
        }
    }
    
    
    func timeToMoveOn() {
        self.performSegueWithIdentifier("unwindFromAFCVC", sender: self)
        recordRef.removeValue()
        
    }
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: Selector("createAlert4"), userInfo: "timer", repeats:false)
    }
    
    func resetTimer(){
        
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: Selector("createAlert4"), userInfo: "timer", repeats: false)
    }
    
    
}



