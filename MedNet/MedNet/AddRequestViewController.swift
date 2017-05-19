//
//  AddRequestViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/28/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit

class AddRequestViewController: MasterViewController {
    
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var requestTextField: UITextField!
    @IBOutlet weak var nameTextField: SearchTextField!
    
    
    
    var requestCurrentValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorText.isHidden = true
        requestTextField.text = requestCurrentValue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        errorText.isHidden = true
        errorText.text = ""
        
        var validated: Bool = false
        validated = validateUserInput()
        
        if (validated) {
            //add data to UserProfile class
            
            switch(UserProfile.sharedInstance.userType) {
            case "Civilian": Civilian.sharedInstance.insertMedicalRequests(reason: requestTextField.text!, name: nameTextField.text!)
            
            do {
                try Civilian.sharedInstance.fetchProfileHospitalAppointmentAndDonations(userType: "Civilian")
            }
            catch {
                print("unable to update medical appointment and donations from user")
                }
                
                
            case "Doctor": Doctor.sharedInstance.insertMedicalRequests(reason: requestTextField.text!, name: nameTextField.text!)
            
            do {
                try Civilian.sharedInstance.fetchProfileHospitalAppointmentAndDonations(userType: "Doctor")
            }
            catch {
                print("unable to update medical appointment and donations from user")
            }
            
            print("successfully added medical requests")
            default: print("user not of type Civilian or doctor")
            }
            
            //go to back page
            performSegueToReturnBack()
        }
        else {
            errorText.isHidden = false
        }
    }
    
    
    func validateUserInput() -> Bool {
        if (requestTextField.text?.isEmpty)! {
            errorText.text = "Can't add empty request"
            return false
        }
        else if (nameTextField.text?.isEmpty)! {
            errorText.text = "All fields are mandatory"
            return false
        }
        //if it reaches here, means validation successful
        return true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
