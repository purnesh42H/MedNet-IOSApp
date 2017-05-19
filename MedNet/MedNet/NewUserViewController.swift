//
//  NewUserViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/25/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit
import SQLite

class NewUserViewController: MasterViewController {
    
    
    @IBOutlet weak var userNameTextField: JVFloatLabeledTextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var userTypeTextField: IQDropDownTextField!
    @IBOutlet weak var userInformationView: UIView!
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var emailId: JVFloatLabeledTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        errorText.isHidden = true
        configureDropDownTextField(textField: userTypeTextField, list: userTypeList)
        userInformationView.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func userTypeTextFieldEditingDidEnd(_ sender: Any) {
        if (userTypeTextField.selectedItem == nil) {
            userInformationView.isHidden = true
        }
        else {
            print("userTypeTextField.optionalItemText!", userTypeTextField.optionalItemText!)
            switch(userTypeTextField.selectedItem!) {
            case "Civilian", "Doctor":
                userInformationView.isHidden = false
                userType = userTypeTextField.selectedItem!
                firstName.placeholder = "First name"
                lastName.placeholder = "Last name"
                
            case "Hospital", "Volunteer organization":
                userInformationView.isHidden = false
                firstName.placeholder = "Organization name"
                lastName.placeholder = "Location"
                
                userType = userTypeTextField.selectedItem!
                
            default:
                userInformationView.isHidden = true
            }
            
        }
    }
    var name = ""
    
    @IBAction func registerButtonTapped(_ sender: UIBarButtonItem) {
        errorText.isHidden = true
        var validated: Bool = false
        validated = validateUserInput()
        
        
        if (validated) {
            print("add a new user")
            name = firstName.text! + " " + lastName.text!
            UserProfile.sharedInstance.userName = userNameTextField.text!
            UserProfile.sharedInstance.userType = userType
            switch(userType) {
            case "Civilian": Civilian.sharedInstance.insertCivilianIntoDb(name: name, email: emailId.text!, phone: Int64(phoneNumber.text!)!, userName: userNameTextField.text!)
                 navigate(segue: "segueFromRegisterToCivilianVC")
              
            case "Doctor": Doctor.sharedInstance.insertDoctorIntoDb(name: name, email: emailId.text!, phone: Int64(phoneNumber.text!)!, userName: userNameTextField.text!)
                navigate(segue: "segueFromRegisterToDoctorVC")
                
            case "Volunteer organization": VolunteerOrganization.sharedInstance.insertVolunteerOrganizationIntoDb(name: name, email: emailId.text!, phone: Int64(phoneNumber.text!)!, userName: userNameTextField.text!)
            navigate(segue: "segueFromRegisterToVolunteerOrganizationVC")
                
            case "Hospital": Hospital.sharedInstance.insertHospitalIntoDb(name: name, email: emailId.text!, phone: Int64(phoneNumber.text!)!, userName: userNameTextField.text!)
            navigate(segue: "segueFromRegisterToHospitalServicesVC")
                
            default: print("Did not match any user type")
            errorText.text = "Something went wrong, please try again."
            errorText.isHidden = false
            }
        }
        else {
            errorText.isHidden = false
        }
        
        if (validated) {
            //go to home page
            //navigateToHomePage()
        }
    }
    
    var MedNetUserId: Int64?
    func validateUserInput() -> Bool {
        do {
            //check for userName
            if (userNameTextField.text! != "") {
                print("trying to fetch from db")
                userType = try Registered.getUserTypeFromDb(userName: userNameTextField.text!)
            }
        }
        catch {
            print("Failed to get userName")
        }
        
        //userName already existed
        if (userType != "") {
            errorText.text = "User name already exists. Try another user name."
            return false
        }
        
        //check for userTypeTextField
        if (userTypeTextField.selectedItem != nil) {
            switch(userTypeTextField.selectedItem!) {
            case "Civilian", "Doctor", "Hospital", "Volunteer organization" :
                userType = userTypeTextField.selectedItem!
            default:
                errorText.text = "Incorrect \"Register as\" type added"
                return false
            }
        }
        else {
            errorText.text = "Incorrect \"Register as\" type added"
            return false
        }
        
        //check for other fields
        if((firstName.text! == "") || (lastName.text! == "") || (phoneNumber.text! == "")) || (emailId.text! == "") {
            errorText.text = "All fields are mandatory"
            return false
        }
        
        //if reached till here, means validation successful.
        return true
        
    }
}





/*do {
 let phoneId = try PhoneDataHelper.insert(
 Phone(id: 0,
 countryCode: Int64(countryCode.text!),
 areaCode: Int64(areaCode.text!),
 phoneNo: Int64(phoneNumber.text!)))
 print("added phone number", phoneId)
 
 let MedNetUserId = try MedNetUserDataHelper.insert(
 MedNetUser(id: 0,
 firstName: firstName.text!,
 lastName: lastName.text!,
 phoneNo: Int64(phoneId)))
 
 print("added MedNet User", MedNetUserId)
 */
//performSegue(withIdentifier: "segueFromRegistrationToProfileAddViewController", sender: self)

/* } catch _{
 print("error in adding phone number")
 errorText.isHidden = false
 
 }*/






/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


