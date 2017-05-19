//
//  HospitalAppointmentViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/27/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit

class HospitalAppointmentViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var hospitalAppointmentView: UIView!
    @IBOutlet weak var hospitalAppointmentTableView: UITableView!
    var editRequestString = ""
    var hospitalAppointments: Array<HospitalAppointment> = Array()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        switch(UserProfile.sharedInstance.userType) {
        case "Civilian":
            hospitalAppointments = Civilian.sharedInstance.hospitalAppointments
        case "Doctor":
            hospitalAppointments = Doctor.sharedInstance.hospitalAppointments
        default:
            print("userType is not Doctor or Civilian")
        }
        hospitalAppointmentTableView.reloadData()
        showOrHideTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //show or hide tableView based on Hospital appointments
        self.configureTableView()
        
            }
    
    func configureTableView() {
        // hospitalAppointmentTableView Delegate
        hospitalAppointmentTableView.delegate      =   self
        hospitalAppointmentTableView.dataSource    =   self
        //self.hospitalAppointmentTableView.rowHeight = 44.0
        
        // Set color of hospitalAppointmentTableView
        hospitalAppointmentTableView.backgroundColor = UIColor.white
    }
    
    func showOrHideTableView() {
        if (hospitalAppointments.count == 0) {
                hospitalAppointmentView.isHidden = true
            }
            else {
                hospitalAppointmentView.isHidden = false
            }
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitalAppointments.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right element
        let hospitalAppointment = hospitalAppointments[indexPath.row]
        
        let cellIdentifier = "HospitalAppointmentCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TDBadgedCell
        if(cell == nil) {
            cell = TDBadgedCell(style: .default, reuseIdentifier: cellIdentifier);
        }
        //HospitalAppointment(hospitalName: <#T##String#>, appointmentId: <#T##Int64#>, date: <#T##String#>, reason: <#T##String#>, start: <#T##String#>, end: <#T##String#>)
        
        let badgeString =  hospitalAppointment.date
        cell?.badgeString = badgeString!
        cell?.badgeColor = .green
        //cell?.badgeColorHighlighted = .green
        cell?.badgeTextColor = .white
        cell?.badgeFontSize = 18
        cell?.badgeRadius = 20
        
        let id = "ID: " + String(describing: hospitalAppointment.appointmentId!) + "\n"
        let hname = "Name: " + hospitalAppointment.hospitalName! + "\n"
        let reason = "Reason: " + hospitalAppointment.reason! + "\n"
        let time = "Time: " + hospitalAppointment.start! + " to " + hospitalAppointment.end!
        
        
        let textLabel = id + hname + reason + time
            
        
        cell?.textLabel?.numberOfLines=0
        cell?.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell?.textLabel?.text = textLabel
        //cell?.detailTextLabel?.text = "Request type: " + hospitalAppointment?.requestType!
        
        // Returning the cell
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*func getBadgeConfigurations(status: Status) -> (color: UIColor, string: String) {
        switch(status.rawValue) {
        case "Canceled": return (.red, "Cancelled")
        case "Pending": return (.orange, "Pending")
        case "Completed": return (.green, "Completed")
        case "Denied": return (.red, "Denied")
        default: return (.red, "Denied")
        }
    }*/
    
    
    //to add swipe to delete and edit feature
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {action in
            //handle delete
            self.hospitalAppointments.remove(at: indexPath.row)
            
            //to reload the AllergiesTableView
            self.hospitalAppointmentTableView.reloadData()
            self.showOrHideTableView()
            
        }
        
        return [deleteAction]
    }
    
    // MARK: - Navigation
    @IBAction func addButtonTapped() {
        navigate(segue: "segueFromHospitalAppointmentToAddAppointmentViewController")
    }
    
    //to transfer data for edit action to Add page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let addRequestVC = segue.destination as? AddRequestViewController {
            addRequestVC.requestCurrentValue = self.editRequestString
            editRequestString = ""
        }
    }
}
