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

class AFCPicksViewController: UIViewController {
    
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
    var thanksView: UIView!
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
    
    var afcPicks : NSMutableArray = NSMutableArray()
    var afcPicks2 : NSMutableArray = NSMutableArray()
    var nfcPicks : NSMutableArray = NSMutableArray()
    var nfcPicks2 : NSMutableArray = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(nfcPicks)
        self.animator = UIDynamicAnimator(referenceView: self.view)
        circularProgressView.angle = 0
//        createOverlay()
//        showThanksView()
        
        
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
        
        //        let X_Co = Float(self.view.frame.size.width - 300)/2
        //        button2.frame = CGRectMake(X_Co, 50, 300, 50)
        
        let labelX = ((view.bounds.width - 600) / 2)
        let labelY = ((view.bounds.height - 400) / 2)
        
        thanksView = UIView()
        thanksView.frame = CGRectMake(labelX, labelY, 600, 400)
        thanksView.backgroundColor = UIColor.clearColor()
        thanksView.alpha = 0.0
        //        thanksView.layer.shadowColor = UIColor.redColor().CGColor
        //        thanksView.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 12.0).CGPath
        //        thanksView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        //        thanksView.layer.shadowOpacity = 1.0
        //        thanksView.layer.shadowRadius = 2
        //        thanksView.layer.masksToBounds = true
        thanksView.layer.cornerRadius = 100
        thanksView.clipsToBounds = true
        //
        view.addSubview(thanksView)

        
        let blur =  UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView  = UIVisualEffectView(effect: blur)
        blurView.frame  = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
        blurView.alpha = 1.0
        thanksView.addSubview(blurView)
        
        let vibrancyView: UIVisualEffectView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blur))
        vibrancyView.frame  = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
        blurView.addSubview(vibrancyView)
        
        
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            
                        self.thanksView.alpha = 1.0
            
                        }, completion: nil)
    
    }
    
//    func showThanksView() {
//    
//        let labelX = ((view.bounds.width - 600) / 2)
//        let labelY = ((view.bounds.height - 800) / 2)
//        
//        
//        thanksView = UIView()
//        thanksView.frame = CGRectMake(labelX, labelY, 600, 800)
//        thanksView.backgroundColor = UIColor.whiteColor()
//        thanksView.alpha = 0.0
////        thanksView.layer.shadowColor = UIColor.redColor().CGColor
////        thanksView.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 12.0).CGPath
////        thanksView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
////        thanksView.layer.shadowOpacity = 1.0
////        thanksView.layer.shadowRadius = 2
////        thanksView.layer.masksToBounds = true
//        thanksView.layer.cornerRadius = 100
//        thanksView.clipsToBounds = true
////
//        view.addSubview(thanksView)
//        
////        let overlayImage = UIImage(named: "overlayimage")!
////        let backgroundImageView = UIImageView(image: overlayImage)
////        backgroundImageView.frame = CGRectMake(0, 0, thanksView.bounds.width, thanksView.bounds.height)
////        backgroundImageView.alpha = 0.8
//        
//        
//        
//        //        backgroundImageView.layer.cornerRadius = 100
////        backgroundImageView.clipsToBounds = true
////        thanksView.addSubview(backgroundImageView)
//        
//        let blur =  UIBlurEffect(style: UIBlurEffectStyle.Dark)
//        let blurView  = UIVisualEffectView(effect: blur)
//        blurView.frame  = CGRectMake(0, 0, thanksView.bounds.width, thanksView.bounds.height)
//        blurView.alpha = 1.0
//        thanksView.addSubview(blurView)
//        
//        let vibrancyView: UIVisualEffectView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blur))
//        vibrancyView.frame  = CGRectMake(0, 0, thanksView.bounds.width, thanksView.bounds.height)
//        blurView.contentView.addSubview(vibrancyView)
//        
//    }
//    
//    
//    func showAlert() {
//        // When the alert view is dismissed, I destroy it, so I check for this condition here
//        // since if the Show Alert button is tapped again after dismissing, alertView will be nil
//        // and so should be created again
//        //        if (button == nil) {
//        //            alertButtons()
//        //        }
//        
//                animator.removeAllBehaviors()
//        
//        UIView.animateWithDuration(0.4) {
//            self.overlayView.alpha = 0.0
//        }
////        UIView.animateWithDuration(0.8) {
////            self.thanksView.alpha = 1.0
////        }
//        
//        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
//            
//            self.thanksView.alpha = 1.0
//            
//            }, completion: nil)
////        // Animate the alert view using UIKit Dynamics.
//        
////        let snapBehaviour: UISnapBehavior = UISnapBehavior(item: thanksView, snapToPoint: view.center)
////        animator.addBehavior(snapBehaviour)
//        
//        
//    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func teamProgressButtonTapped(sender: UIButton!) {
        
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
                
                currentCount += 1
                let newAngleValue = newAngle()
                circularProgressView.animateToAngle(newAngleValue, duration: 0.5, completion: nil)
                
                afcPicks.addObject((sender.titleLabel?.text)!)
                afcPicks2.addObject(sender.imageForState(.Selected)!)
                
            }else{
                currentCount -= 1
                let newAngleValue = newAngle()
                circularProgressView.animateToAngle(newAngleValue, duration: 0.5, completion: nil)
                
                afcPicks.removeObject((sender.titleLabel?.text)!)
                afcPicks2.removeObject(sender.imageForState(.Selected)!)
            }
        }
        
        print(sender.state)
        print(afcPicks)
        
        
//                let picksRef = recordRef.childByAppendingPath("picks")
//        
//                let AFCPicks = afcPicks
//        
//                picksRef.updateChildValues(["afcPicks" : AFCPicks])
        
        
        
        
        if  afcPicks.count == (5) {
            
            emailPage()
            
        }else{
            
        }
        
    }
    
    func newAngle() -> Int {
        
        return Int(360 * (currentCount/maxCount))
        
        
        
    }
    
    func emailPage () {
        
        performSegueWithIdentifier("thanks", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "thanks" {
            let thanksViewController = segue.destinationViewController as! PickVerificationViewController
            thanksViewController.recordRef = recordRef
            thanksViewController.nfcPicks = nfcPicks
            thanksViewController.nfcPicks2 = nfcPicks2
            thanksViewController.afcPicks = afcPicks
            thanksViewController.afcPicks2 = afcPicks2
            //            nfcPicksViewController.toRecipient = email.text
            
        }
    }
    
    //    @IBAction func resetButtonTapped(sender: UIButton) {
    //    }
    
}



