//
//  SignUpViewController.swift
//  NFL Picks
//
//  Created by William Judd on 9/27/15.
//  Copyright © 2015 William Judd. All rights reserved.
//

import UIKit
import CoreLocation

class SignUpViewController: UIViewController {

    
//    @IBOutlet weak var cameraContainerView: UIView!
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
    
    
    var nfcPicks: NSMutableArray!
    var afcPicks: NSMutableArray!
    
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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        if UIDevice.currentDevice().model != "iPad" {
        //            logoWidth.constant = 192
        //            logoHeight.constant = 97
        //        }
        deviceID.text = appDelegate.deviceID
        resetForm(self)
        firstName.addTarget(self, action: "validateForm", forControlEvents: UIControlEvents.EditingChanged)
        lastName.addTarget(self, action: "validateForm", forControlEvents: UIControlEvents.EditingChanged)
        email.addTarget(self, action: "validateForm", forControlEvents: UIControlEvents.EditingChanged)
        company.addTarget(self, action: "validateForm", forControlEvents: UIControlEvents.EditingChanged)
        zipCode.addTarget(self, action: "validateForm", forControlEvents: UIControlEvents.EditingChanged)
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(15.0, target: self, selector: "reAuth", userInfo: nil, repeats: true)
    }
    
    func reAuth(){
        if appDelegate.failedAuth {
            appDelegate.auth()
        }
    }
    
    @IBAction func next(sender: AnyObject) {
        recordRef = appDelegate.ref.childByAutoId()
        recordRef.setValue(["deviceID": deviceID.text!, "firstName": firstName.text!, "lastName": lastName.text!, "email": email.text!, "company": company.text!, "zipCode": zipCode.text!,"picks" : "", "timestamp": [".sv":"timestamp"]])
//        if (latitude != nil) {
//            recordRef.updateChildValues(["scanLocation": ["latitude": latitude, "longitude": longitude]])
//            let scanLocationRef = recordRef.childByAppendingPath("scanLocation")
//            if (street != nil) {
//                scanLocationRef.updateChildValues(["street": street])
//            }
//            if (city != nil) {
//                scanLocationRef.updateChildValues(["city": city])
//            }
//            if (state != nil) {
//                scanLocationRef.updateChildValues(["state": state])
//            }
//            if (postalCode != nil) {
//                scanLocationRef.updateChildValues(["postalCode": postalCode])
//            }
//            if (country != nil) {
//                scanLocationRef.updateChildValues(["country": country])
//            }
//        }
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
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        latitude = String(stringInterpolationSegment: manager.location.coordinate.latitude)
//        longitude = String(stringInterpolationSegment: manager.location.coordinate.longitude)
//        locationManager.stopUpdatingLocation()
//        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error) -> Void in
//            if (error != nil) {
//                //                println("Reverse geocoder failed with error" + error.localizedDescription)
//                return
//            }
//            
//            
//            if placemarks.count > 0 {
//                let placemark = placemarks[0] as! CLPlacemark
//                self.street = placemark.thoroughfare
//                if placemark.subThoroughfare != nil {
//                    self.street = placemark.subThoroughfare + " " + self.street
//                }
//                self.city = placemark.locality
//                self.state = placemark.administrativeArea
//                self.postalCode = placemark.postalCode
//                self.country = placemark.country
//            } else {
//                print("Problem with the data received from geocoder")
//            }
//        })
//    }
    
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        CameraManager.sharedInstance.addPreviewLayerToView(self.cameraContainerView)
        firstName.becomeFirstResponder()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
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
        firstName.becomeFirstResponder()
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
    
    
}

