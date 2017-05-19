//
//  MasterViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/25/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit
import SQLite

class MasterViewController: UIViewController {
    let donationTypeList = ["Funds", "Organs"]
    var userType = ""
    let userTypeList = ["Civilian", "Doctor", "Volunteer organization", "Hospital"]
    let bloodTypeList = ["AB+", "AB-", "A+", "A-", "B+", "B-", "O+", "O-"]
    let treatmentSuggestionList = ["Sinus treatment", "Skin treatment", "Teeth treatment"]
    let degreeSuggestionList = ["MBBS", "MD", "PG"]
    let hospitalServicesSuggestionList = ["Cardiology", "Xray", "Orthodontics"]
    let allergySuggestionList = ["Eggs(Food Allergy)",
                                 "Milk(Food Allergy)",
                                 "Peanuts(Food Allergy)",
                                 "Tree nuts(Food Allergy)",
                                 "Fish(Food Allergy)",
                                 "Shellfish(Food Allergy)",
                                 "Wheat(Food Allergy)",
                                 "Soy(Food Allergy)",
                                 "Cat(Pets Allergy)",
                                 "Dog(Pets Allergy)",
                                 "Drug Allergy",
                                 "Dust Allergy",
                                 "Penicillin(Drug Allergy)",
                                 "Skin Allergy",
                                 "Eye Allergy",
                                 "Insect Allergy",
                                 "Latex Allergy",
                                 "Mold Allergy",
                                 "Cockroach Allergy"]
    let certificateSuggestionList = ["Nursing certificate",
                                     "Medical certificate",
                                     "Teeth certificate"]
    
    let cUIDTypeList = ["State Id", "Passport", "Driving Licence"]
    
    let mainDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //To hide keyboard when Tapped around
        hideKeyboardWhenTappedAround()
           }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    //Enables auto search from a list of Strings
    func setSearching(textField: SearchTextField, list: [String]) {
        // Set the array of strings to suggest
        textField.filterStrings(list)
        //textField.filterStrings(list)
        // Then set the inline mode in true/false
        //textField.inlineMode = true
        // Set a visual theme (SearchTextFieldTheme)
        textField.theme = SearchTextFieldTheme.darkTheme()
        // Set specific comparision options - Default: .caseInsensitive
        textField.comparisonOptions = [.caseInsensitive]
    }
    
    
    func configureDropDownTextField(textField: IQDropDownTextField, list: [String]) {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let buttonflexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let buttonDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneClicked))
        toolbar.items = [buttonflexible, buttonDone]
        textField.inputAccessoryView = toolbar
        textField.isOptionalDropDown = true
        textField.itemList = list
    }
    
    func doneClicked() {
        dismissKeyboard()
    }

    
    func navigate(segue: String) {
        performSegue(withIdentifier: segue, sender: self)
    }
    
    func transition(vc: UIViewController) {
        let window = UIApplication.shared.windows[0] as UIWindow
        UIView.transition(
            from: window.rootViewController!.view,
            to: vc.view,
            duration: 0.4,//0.4,
            options: .transitionCrossDissolve,
            completion: {
                finished in window.rootViewController = vc
        })
    }
    
    func navigateToLoginInPage() {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! UINavigationController
        transition(vc: loginVC)
    }
    
    func navigateToHomePage() {
        let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomePage") as! UITabBarController
        transition(vc: homePage)
        //self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension UIImage: Value {
    public class var declaredDatatype: String {
        return Blob.declaredDatatype
    }
    public class func fromDatatypeValue(_ blobValue: Blob) -> UIImage {
        return UIImage(data: Data.fromDatatypeValue(blobValue))!
    }
    public var datatypeValue: Blob {
        return UIImagePNGRepresentation(self)!.datatypeValue
    }
    
}
