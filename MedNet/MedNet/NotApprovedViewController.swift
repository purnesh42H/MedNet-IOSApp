//
//  NotApprovedViewController.swift
//  Pods
//
//  Created by Himanshi Bhardwaj on 3/28/17.
//
//

import UIKit

class NotApprovedViewController: MasterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UserProfile.sharedInstance.approvedStatus == "approved") {
            navigate(segue: "segueFromNotApprovedToOrganizationTabViewController")
        }
        
        
        

        // Do any additional setup after loading the view.
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
