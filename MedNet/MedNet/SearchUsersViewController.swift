//
//  SearchUsersViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 4/2/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit

class SearchUsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchUsersView: UIView!

    @IBOutlet weak var searchUsersTableView: UITableView!
    
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var searchTextField: SearchTextField!
    var searchResultNames: [(String, Int64)] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        errorText.isHidden = true

        // Do any additional setup after loading the view.
        //show or hide tableView based on medical requests
        self.configureTableView()
    }
    
    func configureTableView() {
        // medicalRequestTableView Delegate
        searchUsersTableView.delegate      =   self
        searchUsersTableView.dataSource    =   self
        
        // Set color of medicalRequestTableView
        searchUsersTableView.backgroundColor = UIColor.white
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //searchUsersTableView.reloadData()
        showOrHideTableView()
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        errorText.isHidden = true
        
        if (searchTextField.text?.isEmpty)! {
            errorText.text = "Enter some partial name"
            errorText.isHidden = false
        }
        else {
            switch(UserProfile.sharedInstance.userType) {
            case "Civilian":
                searchResultNames = Civilian.sharedInstance.searchProfiles(searchText: searchTextField.text!)
            case "Doctor":
                searchResultNames = Doctor.sharedInstance.searchProfiles(searchText: searchTextField.text!)
            default: print("user not of type Civilian or doctor")
            }
        }
        
        showOrHideTableView()
        print("searchResultNames:", searchResultNames)
        //todo: add to the UI
        
    }

    func showOrHideTableView() {
        if (searchResultNames.count == 0) {
            searchUsersView.isHidden = true
        }
        else {
            searchUsersView.isHidden = false
            searchUsersTableView.reloadData()
        }
        
    }
    
    //MARK: - Table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right element
        let name = searchResultNames[indexPath.row]
        print("name:", name)
        
        let cellIdentifier = "MedicalRequestCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TDBadgedCell
        if(cell == nil) {
            cell = TDBadgedCell(style: .default, reuseIdentifier: cellIdentifier);
        }
        
        let (badgeColor, badgeString) = getBadgeConfigurations(userType: name.1)
        cell?.badgeString = badgeString
        cell?.badgeColor = badgeColor
        cell?.badgeColorHighlighted = .green
        cell?.badgeTextColor = .white
        cell?.badgeFontSize = 18
        cell?.badgeRadius = 20
        
        cell?.textLabel?.text = name.0
        //cell?.detailTextLabel?.text = "Request type: " + medicalRequest?.requestType!
        
        // Returning the cell
        return cell!
    }
    
    func getBadgeConfigurations(userType: Int64) -> (color: UIColor, string: String) {
        switch(userType) {
        case 1: return (.orange, "Civilian")
        case 2: return (.green, "Doctor")
        case 3: return (.blue, "Volunteer Org")
        case 4: return (.red, "Hospital")
        default: return (.orange, "Civilian")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
