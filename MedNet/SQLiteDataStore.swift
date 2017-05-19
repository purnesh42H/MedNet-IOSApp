//
//  SQLiteDataStore.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/25/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import Foundation
import SQLite

enum DataAccessError: Error {
    case datastore_Connection_Error
    case insert_Error
    case delete_Error
    case search_Error
    case nil_In_Data
}



class SQLiteDataStore {
    static let sharedInstance = SQLiteDataStore()
    let DB: Connection?
    public init() {
        
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        //print("db location:", dbPath)
        let dbPath = "/Users/himanshibhardwaj/IdeaProjects/MedNet/MedNet/MedNet.db"
        do {
            DB = try Connection(dbPath) /*Users/Zion/Documents/TestSQLite/MedNet.db*/
            print("done successfully")
        } catch _ {
            print("Failed to connect to DB.")
            DB = nil
        }
    }
}

