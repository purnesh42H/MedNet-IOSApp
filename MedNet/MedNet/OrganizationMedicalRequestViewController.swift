//
//  OrganizationMedicalRequestViewController.swift
//  
//
//  Created by Himanshi Bhardwaj on 3/28/17.
//
//

import UIKit


class OrganizationMedicalRequestViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var medicalRequestView: UIView!
    @IBOutlet weak var medicalRequestTableView: UITableView!
    var editRequestString = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        medicalRequestTableView.reloadData()
        showOrHideTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //show or hide tableView based on medical requests
        self.configureTableView()
    }
    
    func configureTableView() {
        // medicalRequestTableView Delegate
        medicalRequestTableView.delegate      =   self
        medicalRequestTableView.dataSource    =   self
        
        // Set color of medicalRequestTableView
        medicalRequestTableView.backgroundColor = UIColor.white
    }
    
    func showOrHideTableView() {
        if (UserProfile.sharedInstance.placedMedicalRequests.count == 0) {
            medicalRequestView.isHidden = true
        }
        else {
            medicalRequestView.isHidden = false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserProfile.sharedInstance.placedMedicalRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right element
        let medicalRequest = UserProfile.sharedInstance.placedMedicalRequests[indexPath.row]
        
        let cellIdentifier = "MedicalRequestCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TDBadgedCell
        if(cell == nil) {
            cell = TDBadgedCell(style: .default, reuseIdentifier: cellIdentifier);
        }
        
        let (badgeColor, badgeString) = getBadgeConfigurations(status: (medicalRequest.status!))
        cell?.badgeString = badgeString
        cell?.badgeColor = badgeColor
        //cell?.badgeColorHighlighted = .green
        cell?.badgeTextColor = .white
        cell?.badgeFontSize = 18
        cell?.badgeRadius = 20
        
        cell?.textLabel?.text = medicalRequest.reason
        //cell?.detailTextLabel?.text = "Request type: " + medicalRequest?.requestType!.rawValue
        
        // Returning the cell
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getBadgeConfigurations(status: Status) -> (color: UIColor, string: String) {
        switch(status.rawValue) {
        case "Canceled": return (.red, "Cancelled")
        case "Pending": return (.orange, "Pending")
        case "Completed": return (.green, "Completed")
        case "Denied": return (.red, "Denied")
        default: return (.red, "Denied")
        }
    }
    
    
    //to add swipe to delete and edit feature
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {action in
            //handle delete
            UserProfile.sharedInstance.placedMedicalRequests.remove(at: indexPath.row)
            
            //to reload the AllergiesTableView
            self.medicalRequestTableView.reloadData()
            self.showOrHideTableView()
            
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Approve") {action in
            //handle edit
            self.editRequestString = (UserProfile.sharedInstance.placedMedicalRequests[indexPath.row].reason!)
            
            UserProfile.sharedInstance.placedMedicalRequests.remove(at: indexPath.row)
            
            //to reload the AllergiesTableView
            self.medicalRequestTableView.reloadData()
            
            //go to add page for editing
            self.addButtonTapped()
            
        }
        
        return [deleteAction, editAction]
    }
    
    // MARK: - Navigation
    @IBAction func addButtonTapped() {
        navigate(segue: "segueFromMedicalRequestToAddRequestViewController")
    }
    
    //to transfer data for edit action to Add request page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("editRequestString1", self.editRequestString)
        if let addRequestVC = segue.destination as? AddRequestViewController {
            print("editRequestString3", self.editRequestString)
            addRequestVC.requestCurrentValue = self.editRequestString
            editRequestString = ""
        }
    }
}
