//
//  Util.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/26/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import Foundation

class Util {
    
    let dateFormatter = DateFormatter()
    let currentDate: Date = Date()

    
    init(){
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.none
    }
    
    /*let dateFormat = DateFormatter()
    dateFormat.dateFormat = DateFormatter.Style.short
      http://userguide.icu-project.org/formatparse/datetime
     
    let date = dateFormat.date(from: /* your_date_string */)*/
    
    
}
