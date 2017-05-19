//
//  BecomeADonorViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 4/2/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit

class BecomeADonorViewController: MasterViewController {

    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var donateTextField: IQDropDownTextField!
    @IBOutlet weak var detailsTextField: SearchTextField!
    @IBOutlet weak var donationView: UIView!
    @IBOutlet weak var successText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        errorText.isHidden = true
        successText.isHidden = true
        
         configureDropDownTextField(textField: donateTextField, list: donationTypeList)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donateTextFieldEditingDidEnd(_ sender: Any) {
        if (donateTextField.selectedItem == nil) {
            donationView.isHidden = true
        }
        else {
            switch(donateTextField.selectedItem!) {
            case "Funds":
                detailsTextField.placeholder = "Enter donation amount(Dollars)"
                donationView.isHidden = false
                case "Organs":
                     detailsTextField.placeholder = "Enter organ name"
                donationView.isHidden = false
            default:
                donationView.isHidden = true
            }
        }
    }
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
         errorText.isHidden = true
        
        if (donateTextField.selectedItem == nil) {
            errorText.text = "Donation type is required"
            errorText.isHidden = false
        }
        else if (detailsTextField.text?.isEmpty)! {
            errorText.text = "All fields are mandatory"
            errorText.isHidden = false
        }
        //verified input
        else {
            switch(UserProfile.sharedInstance.userType) {
            case "Civilian":
                Civilian.sharedInstance.insertDonor(donationType: donateTextField.selectedItem!, detail: detailsTextField.text!)
                
                do {
                    try Civilian.sharedInstance.fetchProfileHospitalAppointmentAndDonations(userType: "Civilian")
                }
                catch {
                    print("unable to update medical appointment and donations from user")
                }
                
            case "Doctor":
              Doctor.sharedInstance.insertDonor(donationType: donateTextField.selectedItem!, detail: detailsTextField.text!)
                
              do {
                try Doctor.sharedInstance.fetchProfileHospitalAppointmentAndDonations(userType: "Doctor")
              }
              catch {
                print("unable to update medical appointment and donations from user")
                }

                
            default: print("user not of type Civilian or doctor")
            }
            
            successText.isHidden = false
            //go back
            //performSegueToReturnBack()
            
            

            
            
        }
        

    }

}
