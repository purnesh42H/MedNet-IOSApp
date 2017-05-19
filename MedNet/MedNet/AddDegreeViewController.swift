//
//  AddDegreesViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/26/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit
//import SearchTextField

class AddDegreeViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var DegreesTableView: UITableView!
    @IBOutlet weak var addDegreesView: UIView!
    @IBOutlet weak var haveDegreesSwitch: UISwitch!
    @IBOutlet weak var newDegreeTextField: SearchTextField!
    @IBOutlet weak var errorText: UILabel!
    
    var degreesList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        errorText.isHidden = true
        
        haveDegreesSwitchValueChanged(sender: haveDegreesSwitch)
        
        //New Degree text field
        newDegreeTextField.placeholder = "Add an degree"
        
        setSearching(textField: newDegreeTextField, list: degreeSuggestionList)
    }
    
    func configureTableView() {
        // DegreesTableView Delegate
        DegreesTableView.delegate      =   self
        DegreesTableView.dataSource    =   self
        
        // Set color of DegreesTableView
        DegreesTableView.backgroundColor = UIColor.white
    }
    
    @IBAction func addDegreesButtonTapped(_ sender: UIButton) {
        if (self.newDegreeTextField.text! != "") {
            degreesList.append(self.newDegreeTextField.text!)
            
            //to reload the DegreesTableView
            DegreesTableView.reloadData()
            //reset newDegreeTextField
            newDegreeTextField.text = ""
            newDegreeTextField.placeholder = "Add another degree"
        }
        
    }
    
    
    //MARK: Have Degrees Switch button
    @IBAction func haveDegreesSwitchValueChanged(sender: UISwitch) {
        if sender.isOn {
            addDegreesView.isHidden = false
            //RecommendationEngineData.sharedInstance.haveChildren = true
        }
        else {
            addDegreesView.isHidden = true
            //RecommendationEngineData.sharedInstance.haveChildren = false
        }
    }
    
    //MARK: DegreesTableView table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return degreesList.count //self.ChildrenNameAndAge.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1")! as UITableViewCell
        
        cell.textLabel?.text = degreesList[indexPath.row]
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
            self.degreesList.remove(at: indexPath.row)
            
            //to reload the DegreesTableView
            self.DegreesTableView.reloadData()
            
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") {action in
            //handle edit
            self.newDegreeTextField.text = self.degreesList[indexPath.row]
            self.degreesList.remove(at: indexPath.row)
            
            //to reload the DegreesTableView
            self.DegreesTableView.reloadData()
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
            //add degrees to DB
            Doctor.sharedInstance.insertDegreesIntoDoctor(degreeList: degreesList)
                        
            //go to next page
            Doctor.sharedInstance.getDoctorFromDb(userName: UserProfile.sharedInstance.userName!)
            navigateToHomePage()

            //navigate(segue: "segueFromAddDegreesToAddTreatmentsViewController")
        }
        else {
            errorText.isHidden = false
        }
    }
    
    
    func validateUserInput() -> Bool {
        //nothing to validate till now
        if (degreesList.count == 0) {
            errorText.text = "Atleast one degree is required"
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

