//
//  AddAppointmentViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 4/2/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit

class AddAppointmentViewController: UIViewController {

    @IBOutlet weak var hospitalNameTextField: SearchTextField!
    @IBOutlet weak var dateTextField: JVFloatLabeledTextField!
    @IBOutlet weak var reasonTextField: JVFloatLabeledTextField!
    @IBOutlet weak var startTimeTextField: JVFloatLabeledTextField!
    @IBOutlet weak var endTimeTextField: JVFloatLabeledTextField!
    
    @IBOutlet weak var errorText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        errorText.isHidden = true
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        errorText.isHidden = true
        if ((hospitalNameTextField.text == "") || (dateTextField.text == "") ||
            (reasonTextField.text == "") || (startTimeTextField.text == "") || (endTimeTextField.text == "")) {
            errorText.text = "All fields are mandatory"
            errorText.isHidden = false
        }
        else {
            switch(UserProfile.sharedInstance.userType) {
            case "Civilian":
                Civilian.sharedInstance.insertHospitalAppointments(hospitalName: hospitalNameTextField.text!, date: dateTextField.text!, reason: reasonTextField.text!, start: startTimeTextField.text!, end: endTimeTextField.text!)
                do {
                    try Civilian.sharedInstance.fetchProfileHospitalAppointmentAndDonations(userType: "Civilian")
                }
                catch {
                    print("unable to update medical appointment and donations from user")
                }
            case "Doctor":
                Doctor.sharedInstance.insertHospitalAppointments(hospitalName: hospitalNameTextField.text!, date: dateTextField.text!, reason: reasonTextField.text!, start: startTimeTextField.text!, end: endTimeTextField.text!)
                
                do {
                    try Doctor.sharedInstance.fetchProfileHospitalAppointmentAndDonations(userType: "Doctor")
                }
                catch {
                    print("unable to update medical appointment and donations from user")
                }
                
            default: "Usertype is not Civilian or doctor"
            }
            
            //go to back page
            performSegueToReturnBack()
        }
        
        
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
