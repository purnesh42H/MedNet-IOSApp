//
//  HomeViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/28/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeText.text = "Welcome, " + UserProfile.sharedInstance.userName!
        // Do any additional setup after loading the view.
        //welcomeLabel.text = "Welcome, " + UserProfile.sharedInstance.firstName!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
