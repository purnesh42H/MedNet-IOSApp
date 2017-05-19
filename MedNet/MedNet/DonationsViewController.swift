//
//  DonationsViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 4/28/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit

class DonationsViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var donationsView: UIView!
    @IBOutlet weak var donationsTableView: UITableView!
    var editRequestString = ""
    var donations: [(String, String)] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        donations = UserProfile.sharedInstance.donations
        donationsTableView.reloadData()
        showOrHideTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //show or hide tableView based on Hospital appointments
        self.configureTableView()
        
    }
    
    func configureTableView() {
        // donationsTableView Delegate
        donationsTableView.delegate      =   self
        donationsTableView.dataSource    =   self
        //self.donationsTableView.rowHeight = 44.0
        
        // Set color of donationsTableView
        donationsTableView.backgroundColor = UIColor.white
    }
    
    func showOrHideTableView() {
        if (donations.count == 0) {
            donationsView.isHidden = true
        }
        else {
            donationsView.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donations.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right element
        let donation = self.donations[indexPath.row]
        
        let cellIdentifier = "donationsCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TDBadgedCell
        if(cell == nil) {
            cell = TDBadgedCell(style: .default, reuseIdentifier: cellIdentifier);
        }
        
        let (badgeColor, badgeString, textString) = getBadgeConfigurations(fundType: donation.1)
        cell?.badgeString = badgeString
        cell?.badgeColor = badgeColor
        //cell?.badgeColorHighlighted = .green
        cell?.badgeTextColor = .white
        cell?.badgeFontSize = 18
        cell?.badgeRadius = 20
        let textLabel = textString + donation.0
        
        cell?.textLabel?.numberOfLines=0
        cell?.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell?.textLabel?.text = textLabel
        //cell?.detailTextLabel?.text = "Request type: " + donations?.requestType!
        
        // Returning the cell
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getBadgeConfigurations(fundType: String) -> (color: UIColor, string: String, string: String) {
     switch(fundType) {
     case "organ": return (.orange, "Organ", "Organ name: ")
     case "fund": return (.green, "Fund", "Fund limit: ")
     default: return (.red, "N/A", "N/A")
     }
     }
    
    
    //to add swipe to delete and edit feature
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {action in
            //handle delete
            self.donations.remove(at: indexPath.row)
            
            //to reload the AllergiesTableView
            self.donationsTableView.reloadData()
            self.showOrHideTableView()
            
        }
        
        return [deleteAction]
    }
    
    // MARK: - Navigation
    @IBAction func addButtonTapped() {
        navigate(segue: "segueFromdonationsToAddAppointmentViewController")
    }
    
    //to transfer data for edit action to Add page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addRequestVC = segue.destination as? AddRequestViewController {
            addRequestVC.requestCurrentValue = self.editRequestString
            editRequestString = ""
        }
    }
}

