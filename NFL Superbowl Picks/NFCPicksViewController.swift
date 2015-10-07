//
//  ViewController.swift
//  NFL Picks
//
//  Created by William Judd on 9/26/15.
//  Copyright © 2015 William Judd. All rights reserved.
//

import UIKit
import Foundation
import AssetsLibrary
import MessageUI
import AVFoundation


class NFCPicksViewController: UIViewController {
    
// Bubble Animation
    
    var bubbleSound: SystemSoundID!
    let defaultDuration = 2.0
    let defaultDamping = 0.20
    let defaultVelocity = 6.0
    
// Firebase
    
    var recordRef: Firebase!
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
//    var alertView: UIView!
//    var alertView2: UIView!
//    var button: UIButton!
//    var button2: UIButton!
    var attachmentBehavior : UIAttachmentBehavior!
    var snapBehavior : UISnapBehavior!
    
    @IBOutlet weak var circularProgressView: KDCircularProgress!
    @IBOutlet weak var bucs: UIButton!
    @IBOutlet weak var cardinals: UIButton!
    @IBOutlet weak var cowboys: UIButton!
    @IBOutlet weak var eagles: UIButton!
    @IBOutlet weak var falcons: UIButton!
    @IBOutlet weak var giants: UIButton!
    @IBOutlet weak var greenbay: UIButton!
    @IBOutlet weak var panthers: UIButton!
    @IBOutlet weak var rams: UIButton!
    @IBOutlet weak var redskins: UIButton!
    @IBOutlet weak var saints: UIButton!
    @IBOutlet weak var seahawks: UIButton!
    @IBOutlet weak var vikings: UIButton!
    @IBOutlet weak var lions: UIButton!
    @IBOutlet weak var bears: UIButton!
    @IBOutlet weak var niners: UIButton!
    @IBOutlet weak var nfcLogo: UIImageView!
    
    
    
    
    var nfcPicks : NSMutableArray = NSMutableArray()
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
       
//        let Bucs = bucs
//        let Eagles = eagles
//        let Cardinals = cardinals
//        let Cowboys = cowboys
//        let Falcons = falcons
//        let Giants = giants
//        let Greenbay = greenbay
//        let Panthers = panthers
//        let Rams = rams
//        let Redskins = redskins
//        let Saints = saints
//        let Seahawks = seahawks
//        let Vikings = vikings
//        let Lions = lions
//        let Bears = bears
//        let Niners = niners

        
        self.animator = UIDynamicAnimator(referenceView: self.view)
        circularProgressView.angle = 0
        createOverlay()
        

        
        let bubbles = [self.bucs,self.cardinals,self.cowboys,self.eagles,self.falcons,self.giants,self.greenbay,self.panthers,self.rams,self.redskins,self.saints,self.seahawks,self.vikings,self.lions,self.bears,self.niners]
        
        for bt in bubbles{
            
            // Circle move
            let pathAnimation = CAKeyframeAnimation(keyPath: "position")
            pathAnimation.calculationMode = kCAAnimationPaced
            pathAnimation.fillMode = kCAFillModeForwards
            pathAnimation.removedOnCompletion = false
            pathAnimation.repeatCount = Float.infinity
            pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            
            if (bt == self.bucs) {
                pathAnimation.duration = 5.0
            }else if (bt == self.cardinals){
                pathAnimation.duration = 6.0
            }else if (bt == self.cowboys){
                pathAnimation.duration = 7.0
            }else if (bt == self.eagles){
                pathAnimation.duration = 8.0
            }else if (bt == self.falcons){
                pathAnimation.duration = 6.0
            }else if (bt == self.giants){
                pathAnimation.duration = 7.0
            }else if (bt == self.greenbay){
                pathAnimation.duration = 8.0
            }else if (bt == self.panthers){
                pathAnimation.duration = 6.0
            }else if (bt == self.rams){
                pathAnimation.duration = 7.0
            }else if (bt == self.redskins){
                pathAnimation.duration = 8.0
            }else if (bt == self.saints){
                pathAnimation.duration = 6.0
            }else if (bt == self.seahawks){
                pathAnimation.duration = 7.0
            }else if (bt == self.vikings){
                pathAnimation.duration = 8.0
            }else if (bt == self.lions){
                pathAnimation.duration = 6.0
            }else if (bt == self.bears){
                pathAnimation.duration = 7.0
            }else if (bt == self.niners){
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
            
            
            if (bt == self.bucs) {
                scaleX.duration = 3
            }else if (bt == self.cardinals){
                scaleX.duration = 4
            }else if (bt == self.cowboys){
                scaleX.duration = 6
            }else if (bt == self.eagles){
                scaleX.duration = 5
            }else if (bt == self.falcons){
                scaleX.duration = 4
            }else if (bt == self.giants){
                scaleX.duration = 6
            }else if (bt == self.greenbay){
                scaleX.duration = 5
            }else if (bt == self.panthers){
                scaleX.duration = 4
            }else if (bt == self.rams){
                scaleX.duration = 6
            }else if (bt == self.redskins){
                scaleX.duration = 5
            }else if (bt == self.saints){
                scaleX.duration = 4
            }else if (bt == self.seahawks){
                scaleX.duration = 6
            }else if (bt == self.vikings){
                scaleX.duration = 5
            }else if (bt == self.lions){
                scaleX.duration = 4
            }else if (bt == self.bears){
                scaleX.duration = 6
            }else if (bt == self.niners){
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
            
            if (bt == self.bucs) {
                scaleY.duration = 3
            }else if (bt == self.cardinals){
                scaleY.duration = 4
            }else if (bt == self.cowboys){
                scaleY.duration = 6
            }else if (bt == self.eagles){
                scaleY.duration = 5
            }else if (bt == self.falcons){
                scaleY.duration = 4
            }else if (bt == self.giants){
                scaleY.duration = 6
            }else if (bt == self.greenbay){
                scaleY.duration = 5
            }else if (bt == self.panthers){
                scaleY.duration = 4
            }else if (bt == self.rams){
                scaleY.duration = 6
            }else if (bt == self.redskins){
                scaleY.duration = 5
            }else if (bt == self.saints){
                scaleY.duration = 4
            }else if (bt == self.seahawks){
                scaleY.duration = 6
            }else if (bt == self.vikings){
                scaleY.duration = 5
            }else if (bt == self.lions){
                scaleY.duration = 4
            }else if (bt == self.bears){
                scaleY.duration = 6
            }else if (bt == self.niners){
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
        
        let blur =  UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView  = UIVisualEffectView(effect: blur)
        blurView.frame  = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
        blurView.alpha = 0.8
        
        
        let vibrancyView: UIVisualEffectView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blur))
        vibrancyView.frame  = CGRectMake(0, 0, view.bounds.width, view.bounds.height)

        let overlayImage = UIImage(named: "overlayimage")!
        let backgroundImageView = UIImageView(image: overlayImage)
        backgroundImageView.frame = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
        
        
        view.addSubview(overlayView)
        overlayView.addSubview(backgroundImageView)
        overlayView.addSubview(blurView)
        blurView.contentView.addSubview(vibrancyView)
        
        
    
    
        
        let button2 = UIButton(type: UIButtonType.System) as UIButton
        button2.setTitle("Pick AFC", forState: UIControlState.Normal)
        button2.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button2.titleLabel?.font = UIFont(name: "Georgia-BoldItalic", size: 30)
        button2.titleLabel?.layer.shadowColor = UIColor.grayColor().CGColor
        button2.titleLabel?.layer.shadowRadius = 4
        button2.titleLabel?.layer.shadowOpacity = 0.9
        button2.titleLabel?.layer.shadowOffset = CGSizeZero
        button2.titleLabel?.layer.masksToBounds = false
        button2.backgroundColor = UIColor.redColor()
        button2.frame = CGRectMake(-500, view.bounds.height / 2 + 50, 300, 50)
        button2.layer.cornerRadius = 10
        button2.addTarget(self, action: Selector("afcPicks"), forControlEvents: UIControlEvents.TouchUpInside)
        //
        
        overlayView.addSubview(button2)
        
//        self.animator = UIDynamicAnimator(referenceView: self.view)
        
        
        
        let snapBehaviour2: UISnapBehavior = UISnapBehavior(item: button2, snapToPoint: CGPointMake(view.bounds.width / 2, view.bounds.height / 2 + 50))
        snapBehaviour2.damping = 0.9
        
        
        let slowDown: UIDynamicItemBehavior = UIDynamicItemBehavior(items: [button2])
        
        //
        slowDown.resistance = 10
        slowDown.density = 0
        
        
        
        animator.addBehavior(slowDown)
        animator.addBehavior(snapBehaviour2)
    
        
    
    }
    


    
    
    
    
    func showAlert() {
        // When the alert view is dismissed, I destroy it, so I check for this condition here
        // since if the Show Alert button is tapped again after dismissing, alertView will be nil
        // and so should be created again
//        if (button == nil) {
//            alertButtons()
//        }
        
//        animator.removeAllBehaviors()
        
        
        
        UIView.animateWithDuration(0.6) {
            self.overlayView.alpha = 1.0
        
        }
        
    }

    @IBAction func teamProgressButtonTapped(sender: UIButton!) {
        
        eagles.setImage(UIImage(named: "eagles"), forState:.Normal);
                eagles.setImage(UIImage(named: "Broncos Gold"), forState:.Selected);
        
        bucs.setImage(UIImage(named: "buccs"), forState:.Normal);
                bucs.setImage(UIImage(named: "lions"), forState:.Selected);
        
        panthers.setImage(UIImage(named: "panthers"), forState:.Normal);
                panthers.setImage(UIImage(named: "lions"), forState:.Selected);
        
        if sender == sender {
            
            sender.selected = !sender.selected
        
            if sender.state.rawValue == 5  {
             
                currentCount += 1
                let newAngleValue = newAngle()
                circularProgressView.animateToAngle(newAngleValue, duration: 0.5, completion: nil)
            
            nfcPicks.addObject((sender.titleLabel?.text)!)
            
        }else{
                currentCount -= 1
                let newAngleValue = newAngle()
                circularProgressView.animateToAngle(newAngleValue, duration: 0.5, completion: nil)
                
            nfcPicks.removeObject((sender.titleLabel?.text)!)
                
            }
        }
        
            print(sender.state)
            print(nfcPicks)
        
    
//        let picksRef = recordRef.childByAppendingPath("picks")
//        
//        let NFCPicks = nfcPicks
//        
//        picksRef.updateChildValues(["nfcPicks" : NFCPicks])
//    
//    
    
    
    if  nfcPicks.count == (5) {
       
        showAlert()
    
            }else{
        
    }

}

    func newAngle() -> Int {
        
        return Int(360 * (currentCount/maxCount))
    
    
    
    }
    
    
    func afcPicks () {
        
        performSegueWithIdentifier("afcpicks", sender: self)
        
    }
    
//    @IBAction func resetButtonTapped(sender: UIButton) {
//    }
  
}



