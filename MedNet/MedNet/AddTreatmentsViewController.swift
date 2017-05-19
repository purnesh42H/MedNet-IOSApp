//
//  AddTreatmentsViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/27/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit
//import SearchTextField


class AddTreatmentsViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var TreatmentTableView: UITableView!
    @IBOutlet weak var addTreatmentView: UIView!
    @IBOutlet weak var haveTreatmentSwitch: UISwitch!
    @IBOutlet weak var newTreatmentTextField: SearchTextField!
    @IBOutlet weak var errorText: UILabel!
    
    var treatmentList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        errorText.isHidden = true
        
        haveTreatmentSwitchValueChanged(sender: haveTreatmentSwitch)
        
        //New Treatment text field
        newTreatmentTextField.placeholder = "Add a treatment"
        
        setSearching(textField: newTreatmentTextField, list: treatmentSuggestionList)
    }
    
    func configureTableView() {
        // TreatmentTableView Delegate
        TreatmentTableView.delegate      =   self
        TreatmentTableView.dataSource    =   self
        
        // Set color of TreatmentTableView
        TreatmentTableView.backgroundColor = UIColor.white
    }
    
    @IBAction func addTreatmentButtonTapped(_ sender: UIButton) {
        if (self.newTreatmentTextField.text! != "") {
            treatmentList.append(self.newTreatmentTextField.text!)
            
            //to reload the TreatmentTableView
            TreatmentTableView.reloadData()
            //reset newTreatmentTextField
            newTreatmentTextField.text = ""
            newTreatmentTextField.placeholder = "Add another treatment"
        }
    }
    
    
    //MARK: Have Treatment Switch button
    @IBAction func haveTreatmentSwitchValueChanged(sender: UISwitch) {
        if sender.isOn {
            addTreatmentView.isHidden = false
            //RecommendationEngineData.sharedInstance.haveChildren = true
        }
        else {
            addTreatmentView.isHidden = true
            //RecommendationEngineData.sharedInstance.haveChildren = false
        }
    }
    
    //MARK: TreatmentTableView table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return treatmentList.count //self.ChildrenNameAndAge.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1")! as UITableViewCell
        
        cell.textLabel?.text = treatmentList[indexPath.row]
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
            self.treatmentList.remove(at: indexPath.row)
            
            //to reload the TreatmentTableView
            self.TreatmentTableView.reloadData()
            
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") {action in
            //handle edit
            //handle delete
            self.newTreatmentTextField.text = self.treatmentList[indexPath.row]
            self.treatmentList.remove(at: indexPath.row)
            
            //to reload the TreatmentTableView
            self.TreatmentTableView.reloadData()
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
            //add data to UserProfile class
            UserProfile.sharedInstance.setTreatments(treatments: treatmentList)
            
            //go to next page
            navigate(segue: "segueFromAddTreatmentsToAddCertificatesViewController")
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
