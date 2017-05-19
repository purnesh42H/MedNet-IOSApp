//
//  ProfileViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/28/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit

class ProfileViewController: MasterViewController {
    
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var phoneNumberTextField: UILabel!
    @IBOutlet weak var dateOfBirthTextField: UILabel!
    @IBOutlet weak var bloodTypeTextField: UILabel!
    @IBOutlet weak var allergiesTextField: UILabel!
    @IBOutlet weak var certificatesTextField: UILabel!
    @IBOutlet weak var treatmentsTextField: UILabel!
    var allergies = Set<String>()
    var certificates = Set<String>()
    var treatments = Set<String>()
    var allergiesText = ""
    var certificatesText = ""
    var treatmentsText = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadProfileInformation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfileInformation()
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserProfile.sharedInstance = UserProfile()
        Civilian.sharedInstance = Civilian()
        Doctor.sharedInstance = Doctor()
        navigateToLoginInPage()
    }
    
    func loadProfileInformation() {
        var allergiesText = ""
        var certificatesText = ""
        var treatmentsText = ""
        
        switch(UserProfile.sharedInstance.userType) {
        case "Civilian":
            nameTextField.text = Civilian.sharedInstance.name
            phoneNumberTextField.text = String(describing: Civilian.sharedInstance.phoneNo!)
            dateOfBirthTextField.text = Civilian.sharedInstance.profile?.dateOfBirth! ?? "N/A"
            
            bloodTypeTextField.text = Civilian.sharedInstance.profile?.bloodType?.rawValue
            if (Civilian.sharedInstance.profile?.allergiesSet != nil) {
                allergies = (Civilian.sharedInstance.profile?.allergiesSet)!
            }
            if (Civilian.sharedInstance.profile?.certificatesSet != nil) {
                certificates =  (Civilian.sharedInstance.profile?.certificatesSet)!
            }
            if (Civilian.sharedInstance.profile?.treatmentSet != nil) {
                treatments = (Civilian.sharedInstance.profile?.treatmentSet)!
            }
            
        case "Doctor":
            nameTextField.text = Doctor.sharedInstance.name
            phoneNumberTextField.text = String(describing: Doctor.sharedInstance.phoneNo!)
            dateOfBirthTextField.text = Doctor.sharedInstance.profile?.dateOfBirth! ?? "N/A"
            
            bloodTypeTextField.text = Doctor.sharedInstance.profile?.bloodType?.rawValue
            if (Doctor.sharedInstance.profile?.allergiesSet != nil) {
                allergies = (Doctor.sharedInstance.profile?.allergiesSet)!
            }
            if (Doctor.sharedInstance.profile?.certificatesSet != nil) {
                certificates =  (Doctor.sharedInstance.profile?.certificatesSet)!
            }
            if (Doctor.sharedInstance.profile?.treatmentSet != nil) {
                treatments = (Doctor.sharedInstance.profile?.treatmentSet)!
            }
            
        default: print("Not a doctor or civilian")
        }
        
        //Allergies
        if (allergies.count == 0) {
            allergiesText = "Not added"
        }
        else {
            
            for allergy in allergies {
                allergiesText += allergy + "\n"
            }
        }
        
        //certificates
        if (certificates.count == 0) {
            certificatesText = "Not added"
        }
        else {
            
            for certificate in certificates {
                certificatesText += certificate + "\n"
            }
        }
        
        //treatments
        if (treatments.count == 0) {
            treatmentsText = "Not added"
        }
        else {
            
            for treatment in treatments {
                treatmentsText += treatment + "\n"
            }
        }
        
        allergiesTextField.text = allergiesText
        certificatesTextField.text = certificatesText
        treatmentsTextField.text = treatmentsText
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
