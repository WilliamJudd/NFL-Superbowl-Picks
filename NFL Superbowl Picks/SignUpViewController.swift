//
//  SignUpViewController.swift
//  NFL Picks
//
//  Created by William Judd on 9/27/15.
//  Copyright © 2015 William Judd. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class SignUpViewController: UIViewController {

    var recordRef: Firebase!
    let locationManager = CLLocationManager() //?????
    var latitude: String!
    var longitude: String!
    var street: String!
    var city: String!
    var postalCode: String!
    var country: String!
    var state: String!
    var updateTimer: NSTimer!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var nfcPicks: NSMutableArray!
    var afcPicks: NSMutableArray!

    
    
    @IBOutlet weak var blurImage: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var deviceID: UILabel!
    @IBOutlet weak var firstNameCheck: UIImageView!
    @IBOutlet weak var lastNameCheck: UIImageView!
    @IBOutlet weak var emailCheck: UIImageView!
    @IBOutlet weak var companyCheck: UIImageView!
    @IBOutlet weak var zipCodeCheck: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var logoWidth: NSLayoutConstraint!
    @IBOutlet weak var logoHeight: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deviceID.text = appDelegate.deviceID
        resetForm(self)
        firstName.addTarget(self, action: "validateForm", forControlEvents: UIControlEvents.EditingChanged)
        lastName.addTarget(self, action: "validateForm", forControlEvents: UIControlEvents.EditingChanged)
        email.addTarget(self, action: "validateForm", forControlEvents: UIControlEvents.EditingChanged)
        company.addTarget(self, action: "validateForm", forControlEvents: UIControlEvents.EditingChanged)
        zipCode.addTarget(self, action: "validateForm", forControlEvents: UIControlEvents.EditingChanged)
        
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(15.0, target: self, selector: "reAuth", userInfo: nil, repeats: true)
        
//        updateTimer = NSTimer.scheduledTimerWithTimeInterval(15.0, target: self, selector: "reAuth", userInfo: nil, repeats: true)
//    
    
    // Firebase update to see if anybody is using the app.
    
    }
    
    func reAuth(){
        if appDelegate.failedAuth {
            appDelegate.auth()
        }
    }
        
    
    @IBAction func next(sender: AnyObject) {
        recordRef = appDelegate.ref.childByAutoId()
        recordRef.setValue(["deviceID": deviceID.text!, "firstName": firstName.text!, "lastName": lastName.text!, "email": email.text!, "company": company.text!, "zipCode": zipCode.text!,"picks" : "", "timestamp": [".sv":"timestamp"]])

                performSegueWithIdentifier("picks", sender: nil)
    
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "picks" {
            let nfcPicksViewController = segue.destinationViewController as! NFCPicksViewController
            nfcPicksViewController.recordRef = recordRef
            
            
            
            //            nfcPicksViewController.toRecipient = email.text
            resetForm(self)
        }
    }

    
    func validateForm() {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        firstNameCheck.alpha = firstName.text!.characters.count > 1 ? 1 : 0
        lastNameCheck.alpha = lastName.text!.characters.count > 1 ? 1 : 0
        emailCheck.alpha = emailTest.evaluateWithObject(email.text) ? 1 : 0
        companyCheck.alpha = company.text!.characters.count > 1 ? 1 : 0
        zipCodeCheck.alpha = zipCode.text!.characters.count > 1 ? 1 : 0
        nextButton.enabled = firstNameCheck.alpha == 1 && lastNameCheck.alpha == 1 && emailCheck.alpha == 1 && companyCheck.alpha == 1 && zipCodeCheck.alpha == 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @IBAction func resetForm(sender: AnyObject) {
        firstName.text = ""
        lastName.text = ""
        email.text = ""
        company.text = ""
        zipCode.text = ""
        firstNameCheck.alpha = 0
        lastNameCheck.alpha = 0
        emailCheck.alpha = 0
        companyCheck.alpha = 0
        zipCodeCheck.alpha = 0
        nextButton.enabled = false
//        firstName.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        if textField == firstName {
            lastName.becomeFirstResponder()
        }
        if textField == lastName {
            email.becomeFirstResponder()
        }
        if textField == email {
            company.becomeFirstResponder()
        }
        if textField == company {
            zipCode.becomeFirstResponder()
        }
        if textField == zipCode {
            if nextButton.enabled {
                nextButton.sendActionsForControlEvents(.TouchUpInside)
            }
        }
        return true
    }
    
    
    func timeToMoveOn() {
        self.performSegueWithIdentifier("unwindFromLoginVC", sender: self)
        
    }

    
    
}

