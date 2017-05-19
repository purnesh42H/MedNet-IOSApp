//
//  MedicalRequestFullViewController.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 4/28/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit

class MedicalRequestFullViewController: MasterViewController, SJFluidSegmentedControlDataSource, SJFluidSegmentedControlDelegate {
    
    
    @IBOutlet weak var toggler: SJFluidSegmentedControl!
    weak var currentViewController: UIViewController?
    @IBOutlet weak var placedMedicalRequestsView: UIView!
    
    @IBOutlet weak var recievedMedicalRequestsView: UIView!
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //showing basicInfoContainerView, and hiding others
        placedMedicalRequestsView.showView()
        recievedMedicalRequestsView.hideView()
        
        if #available(iOS 8.2, *) {
            toggler.textFont = .systemFont(ofSize: 16, weight: UIFontWeightSemibold)
        } else {
            toggler.textFont = .boldSystemFont(ofSize: 16)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        return 2
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          titleForSegmentAtIndex index: Int) -> String? {
        if index == 0 {
            return "Placed requests"
        } else if index == 1 {
            return "Recieved requests"
        }
        return "Nothing".uppercased()
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor] {
        switch index {
        case 0:
            return [UIColor(red: 21 / 255.0, green: 94 / 255.0, blue: 119 / 255.0, alpha: 1.0),
                    UIColor(red: 9 / 255.0, green: 82 / 255.0, blue: 107 / 255.0, alpha: 1.0)]
        case 1:
            return [UIColor(red: 21 / 255.0, green: 94 / 255.0, blue: 119 / 255.0, alpha: 1.0),
                    UIColor(red: 9 / 255.0, green: 82 / 255.0, blue: 107 / 255.0, alpha: 1.0)]
        default:
            break
        }
        return [.clear]
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          gradientColorsForBounce bounce: SJFluidSegmentedControlBounce) -> [UIColor] {
        switch bounce {
        case .left:
            return [UIColor(red: 51 / 255.0, green: 149 / 255.0, blue: 182 / 255.0, alpha: 1.0)]
        case .right:
            return [UIColor(red: 9 / 255.0, green: 82 / 255.0, blue: 107 / 255.0, alpha: 1.0)]
        }
    }
    
    @objc func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                didChangeFromSegmentAtIndex fromIndex: Int,
                                toSegmentAtIndex toIndex:Int) {
        
        if toIndex == 0 {
            placedMedicalRequestsView.showView()
            recievedMedicalRequestsView.hideView()
            
        } else if toIndex == 1 {
            placedMedicalRequestsView.hideView()
            recievedMedicalRequestsView.showView()
            
        }
        
        
    }
    
    
    
    
    
    /*func todo() {
     switch(todo) {
     case 0:
     placedMedicalRequestsView.hideView()
     recievedMedicalRequestsView.showView()
     //placedMedicalRequestsView.showView()
     //recievedMedicalRequestsView.hideView()
     
     case 1:
     placedMedicalRequestsView.hideView()
     recievedMedicalRequestsView.showView()
     
     default:
     placedMedicalRequestsView.showView()
     recievedMedicalRequestsView.hideView()
     }
     }*/
    
}


extension UIView {
    func hideView() -> UIView {
        self.isUserInteractionEnabled = false
        self.isHidden = true
        return self
    }
    
    func showView() -> UIView {
        self.isUserInteractionEnabled = true
        self.isHidden = false
        return self
    }
}

