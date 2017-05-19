//
//  AddProfileViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/26/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit

class AddProfileViewController: MasterViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var bloodTypeTextField: SearchTextField!
    @IBOutlet weak var errorText: UILabel!
    //let bloodTypePickerValues = ["val 1", "val 2", "val 3", "val 4"]
    var bloodTypePicker: UIPickerView! = UIPickerView()
    
    var dateOfBirth: Date?
    var bloodType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorText.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        //To hide keyboard on dateOfBirthTextField
        dateOfBirthTextField.inputView = UIView()
        
        configureBloodTypePicker()
        setSearching(textField: bloodTypeTextField, list: bloodTypeList)
 
    }
    
    /*override func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return true
    }*/

    
    func configureBloodTypePicker() {
        self.bloodTypePicker = UIPickerView(frame: CGRect(x: 0, y: 40,
                                                          width: 0, height: 0))
        self.bloodTypeTextField.delegate = self
        self.bloodTypePicker.delegate = self
        self.bloodTypePicker.dataSource = self
    }
    
    @IBAction func dateOfBirthTextFieldTapped(_ sender: UITextField) {
        //Convert text from dobTextField to Date
        let currentValue : Date?
        if ((self.dateOfBirthTextField.text != nil) && !self.dateOfBirthTextField.text!.isEmpty) {
            currentValue  = Util().dateFormatter.date(from: self.dateOfBirthTextField.text!)!
        } else {
            currentValue  = Util().currentDate
        }
        
        DatePickerDialog().show("Date of Birth", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: currentValue!, datePickerMode: .date) {
            (date) -> Void in
            if (date != nil) {
                
            self.dateOfBirthTextField.text = Util().dateFormatter.string(from: date!)
                self.dateOfBirth = date
            }
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        errorText.isHidden = true
        errorText.text = ""
        
        var validated: Bool = false
        validated = validateUserInput()
        
        if (validated) {
            //add data to UserProfile class
            
            
            UserProfile.sharedInstance.setDateOfBirth(dateOfBirth: dateOfBirth!)
            UserProfile.sharedInstance.setBloodType(bloodType: BloodType(rawValue: bloodType!)!)
            
            //go to next page
            navigate(segue: "segueFromAddProfileToAddAllergiesViewController")
            
        }
        else {
            errorText.isHidden = false
        }
    }
   
    func validateUserInput() -> Bool {
        if dateOfBirth == nil {
            errorText.text = "Incorrect date of birth added"
            return false
        }
        
        switch (bloodTypeTextField.text!) {
        case "AB+", "AB-", "A+", "A-", "B+", "B-", "O+", "O-":
            bloodType = bloodTypeTextField.text!
        default:
            errorText.text = "Incorrect blood type added"
            return false
        }
        
        //if it reaches here, means validation successful
        return true
    }
    
    
    //MARK: - Delegates and data sources for BloodTypePicker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bloodTypeList.count
    }
    
    //MARK: Delegates
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bloodTypeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Your Function
        print("Hello")
    }
    
    /*@IBAction func button(sender: AnyObject) {
        self.textFeild.becomeFirstResponder()
    }*/
    
    func cancelPicker(sender:UIButton) {
        //Remove view when select cancel
        self.bloodTypeTextField.resignFirstResponder() // To resign the inputView on clicking done.
    }
    
    @IBAction func bloodTypeTextFieldEditingDidBegin(_ sender: UITextField) {
    
        //Create the view
        let tintColor: UIColor = UIColor(red: 101.0/255.0, green: 98.0/255.0, blue: 164.0/255.0, alpha: 1.0)
        let inputView = UIView(frame: CGRect(x: 0, y: 0,
                                             width: self.view.frame.width,
                                             height: 240))
        bloodTypePicker.tintColor = tintColor
        bloodTypePicker.center.x = inputView.center.x
        inputView.addSubview(bloodTypePicker) // add date picker to UIView
        let doneButton = UIButton(frame: CGRect(x: 100/2, y: 0,
                                                width: 100,
                                                height: 50))
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(tintColor, for: UIControlState.normal)
        doneButton.setTitleColor(tintColor, for: UIControlState.highlighted)
        inputView.addSubview(doneButton) // add Button to UIView
        doneButton.addTarget(self, action: "doneButton:", for: UIControlEvents.touchUpInside) // set button click event
        
        let cancelButton = UIButton(frame: CGRect(x: (self.view.frame.size.width - 3*(100/2)), y: 0, width: 100, height: 50))
        cancelButton.setTitle("Cancel", for: UIControlState.normal)
        cancelButton.setTitle("Cancel", for: UIControlState.highlighted)
        cancelButton.setTitleColor(tintColor, for: UIControlState.normal)
        cancelButton.setTitleColor(tintColor, for: UIControlState.highlighted)
        inputView.addSubview(cancelButton) // add Button to UIView
        cancelButton.addTarget(self, action: Selector("cancelPicker:"), for: UIControlEvents.touchUpInside) // set button click event
        sender.inputView = inputView
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


