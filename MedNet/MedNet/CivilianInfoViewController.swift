//
//  CivilianInfoViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 4/2/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit

class CivilianInfoViewController: MasterViewController {

    @IBOutlet weak var identificationNumberTextField: JVFloatLabeledTextField!
    @IBOutlet weak var identificationTypeTextField: IQDropDownTextField!
    @IBOutlet weak var errorText: UILabel!
    var cUIDType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorText.isHidden = true
        configureDropDownTextField(textField: identificationTypeTextField, list: cUIDTypeList)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        errorText.isHidden = true
        var validated: Bool = false
        validated = validateUserInput()
        
        if (validated) {
            Civilian.sharedInstance.insertCivilianID(cUID: identificationNumberTextField.text!, cUIDType: self.cUIDType)
            navigate(segue: "segueFromUserInfoToAddProfileToVC")
        }
    }
 
    func validateUserInput() -> Bool {
        //check for userTypeTextField
        if (identificationTypeTextField.selectedItem != nil) {
            cUIDType = identificationTypeTextField.selectedItem!
        }
        else {
            errorText.text = "Incorrect \"identification\" type added"
            return false
        }
        
        //check for other fields
        if (identificationNumberTextField.text! == "") {
            errorText.text = "All fields are mandatory"
            return false
        }
        
        
        //if reached till here, means validation successful.
        return true
        
    }
}


  
