//
//  AddHospitalServicesViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/26/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit
//import SearchTextField

class AddHospitalServicesViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var HospitalServicesTableView: UITableView!
    @IBOutlet weak var addHospitalServicesView: UIView!
    @IBOutlet weak var haveHospitalServicesSwitch: UISwitch!
    @IBOutlet weak var newHospitalServiceTextField: SearchTextField!
    @IBOutlet weak var errorText: UILabel!
    
    var hospitalServicesList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        errorText.isHidden = true
        
        haveHospitalServicesSwitchValueChanged(sender: haveHospitalServicesSwitch)
        
        //New HospitalService text field
        newHospitalServiceTextField.placeholder = "Add an degree"
        
        setSearching(textField: newHospitalServiceTextField, list: degreeSuggestionList)
    }
    
    func configureTableView() {
        // HospitalServicesTableView Delegate
        HospitalServicesTableView.delegate      =   self
        HospitalServicesTableView.dataSource    =   self
        
        // Set color of HospitalServicesTableView
        HospitalServicesTableView.backgroundColor = UIColor.white
    }
    
    @IBAction func addHospitalServicesButtonTapped(_ sender: UIButton) {
        if (self.newHospitalServiceTextField.text! != "") {
            hospitalServicesList.append(self.newHospitalServiceTextField.text!)
            
            //to reload the HospitalServicesTableView
            HospitalServicesTableView.reloadData()
            //reset newHospitalServiceTextField
            newHospitalServiceTextField.text = ""
            newHospitalServiceTextField.placeholder = "Add another degree"
        }
        
    }
    
    
    //MARK: Have HospitalServices Switch button
    @IBAction func haveHospitalServicesSwitchValueChanged(sender: UISwitch) {
        if sender.isOn {
            addHospitalServicesView.isHidden = false
            //RecommendationEngineData.sharedInstance.haveChildren = true
        }
        else {
            addHospitalServicesView.isHidden = true
            //RecommendationEngineData.sharedInstance.haveChildren = false
        }
    }
    
    //MARK: HospitalServicesTableView table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitalServicesList.count //self.ChildrenNameAndAge.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1")! as UITableViewCell
        
        cell.textLabel?.text = hospitalServicesList[indexPath.row]
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
            self.hospitalServicesList.remove(at: indexPath.row)
            
            //to reload the HospitalServicesTableView
            self.HospitalServicesTableView.reloadData()
            
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") {action in
            //handle edit
            self.newHospitalServiceTextField.text = self.hospitalServicesList[indexPath.row]
            self.hospitalServicesList.remove(at: indexPath.row)
            
            //to reload the HospitalServicesTableView
            self.HospitalServicesTableView.reloadData()
        }
        
        return [deleteAction, editAction]
    }
    
    //MARK: - Navigation
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        errorText.isHidden = true
        errorText.text = ""
        
        var validated: Bool = false
        validated = validateUserInput()
        
        if (validated) {
            //add hospitalServices to DB
            Hospital.sharedInstance.insertHospitalServicesIntoDb(hospitalServicesList: hospitalServicesList)
            //go to home page
            //navigateToHomePage()
            
            //navigate(segue: "segueFromAddHospitalServicesToAddTreatmentsViewController")
        }
        else {
            errorText.isHidden = false
        }
    }
    
    
    func validateUserInput() -> Bool {
        //nothing to validate till now
        if (hospitalServicesList.count == 0) {
            errorText.text = "Atleast one hospital service is required"
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

