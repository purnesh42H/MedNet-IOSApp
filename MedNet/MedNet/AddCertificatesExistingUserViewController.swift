//
//  AddCertificatesViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/27/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit
//import SearchTextField


class AddCertificatesExistingUserViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var CertificateTableView: UITableView!
    @IBOutlet weak var addCertificateView: UIView!
    @IBOutlet weak var haveCertificateSwitch: UISwitch!
    @IBOutlet weak var newCertificateTextField: SearchTextField!
    @IBOutlet weak var errorText: UILabel!
    
    var certificateList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        errorText.isHidden = true
        
        haveCertificateSwitchValueChanged(sender: haveCertificateSwitch)
        
        //New Certificate text field
        newCertificateTextField.placeholder = "Add a certificate"
        
        setSearching(textField: newCertificateTextField, list: certificateSuggestionList)
    }
    
    func configureTableView() {
        // CertificateTableView Delegate
        CertificateTableView.delegate      =   self
        CertificateTableView.dataSource    =   self
        
        // Set color of CertificateTableView
        CertificateTableView.backgroundColor = UIColor.white
    }
    
    @IBAction func addCertificateButtonTapped(_ sender: UIButton) {
        if (self.newCertificateTextField.text! != "") {
            certificateList.append(self.newCertificateTextField.text!)
            
            //to reload the CertificateTableView
            CertificateTableView.reloadData()
            //reset newCertificateTextField
            newCertificateTextField.text = ""
            newCertificateTextField.placeholder = "Add another certificate"
        }
    }
    
    
    //MARK: Have Certificate Switch button
    @IBAction func haveCertificateSwitchValueChanged(sender: UISwitch) {
        if sender.isOn {
            addCertificateView.isHidden = false
            //RecommendationEngineData.sharedInstance.haveChildren = true
        }
        else {
            addCertificateView.isHidden = true
            //RecommendationEngineData.sharedInstance.haveChildren = false
        }
    }
    
    //MARK: CertificateTableView table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return certificateList.count //self.ChildrenNameAndAge.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1")! as UITableViewCell
        
        cell.textLabel?.text = certificateList[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        return cell
    }
    
    //to add swipe to delete and edit feature
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {action in
            //handle delete
            self.certificateList.remove(at: indexPath.row)
            
            //to reload the CertificateTableView
            self.CertificateTableView.reloadData()
            
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") {action in
            //handle edit
            //handle delete
            self.newCertificateTextField.text = self.certificateList[indexPath.row]
            self.certificateList.remove(at: indexPath.row)
            
            //to reload the CertificateTableView
            self.CertificateTableView.reloadData()
        }
        
        return [deleteAction, editAction]
    }
    
    //MARK: - Navigation
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        errorText.isHidden = true
        errorText.text = ""
        
        var validated: Bool = false
        validated = validateUserInput()
        
        if (validated) {
            //add data to User class
            switch(UserProfile.sharedInstance.userType) {
            case "Civilian": Civilian.sharedInstance.insertCertificates(certificates: certificateList)
            do {
            try Civilian.sharedInstance.fetchProfileHospitalAppointmentAndDonations(userType: "Civilian")
                }
            catch {
                print("unable to update certificates of the user")
                }
            case "Doctor": Doctor.sharedInstance.insertCertificates(certificates: certificateList)
            do {
                try Doctor.sharedInstance.fetchProfileHospitalAppointmentAndDonations(userType: "Doctor")
            }
            catch {
                print("unable to update certificates of the user")
                }
            //case "VolunteerOrganization": VolunteerOrganization.sharedInstance.getVolunteerOrganizationFromDb(userName: userNameTextField.text!)
            //case "Hospital": Hospital.sharedInstance.getHospitalFromDb(userName: userNameTextField.text!)
            default: print("Did not match any user type")
            errorText.text = "Something went wrong, please try again."
            errorText.isHidden = false
            }
            //Registered.sharedInstance.insertCertificates(certificateList)
            
            UserProfile.sharedInstance.setCertificates(certificates: certificateList)
        }
        else {
            errorText.isHidden = false
        }
    }
    
    
    func validateUserInput() -> Bool {
        //nothing to validate till now
        
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
