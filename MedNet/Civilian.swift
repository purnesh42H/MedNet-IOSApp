//
//  Civilian.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 4/1/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import Foundation

class Civilian : Registered {
    var cUID: String?
    var cUIDType: CUIDType?
    
    static var sharedInstance = Civilian()
    
    func getCivilianFromDb(userName: String) {
        //fetch from Resistered table
        getRegisteredFromDb(userName: userName)
        
        do {
            self.userName = userName
             //fetch from Civilian table
            try self.fetchProfileHospitalAppointmentAndDonations(userType: "Civilian")
            try self.fetchCivilian()
        }
        catch {
            print("Failed to fetch registeredUserfromDb")
        }
    }
    
    func fetchCivilian() throws {
        guard let DB = self.dbInstance.DB else {
            throw DataAccessError.datastore_Connection_Error
        }
        
        do
        {
            let query = "select c.cUID, c.cUIDType from Civilian c where c.id = ?"
            let stmt = try DB.prepare(query)
            for row in try stmt.run(self.id)
            {
                self.cUID = row[0] as? String
                self.cUIDType = getCUIDType(CUIDTypeInt: row[1] as! Int64)
                //CUIDType(rawValue: row[1])
                
            }
            
        }
        catch
        {
            throw DataAccessError.search_Error
        }
        
        //successful data extraction
    }
    
    func getCUIDType(CUIDTypeInt: Int64) -> CUIDType {
        switch(Int(CUIDTypeInt)) {
        case 1: return CUIDType(rawValue: "State Id")!
        case 2: return CUIDType(rawValue: "Passport")!
        case 3: return CUIDType(rawValue: "Driving Licence")!
        default: return CUIDType(rawValue: "State Id")!
        }
    }
    
    func insertCivilianIntoDb(name: String, email: String, phone: Int64, userName: String) {
        do {
            self.userName = userName
            //fetch from Civilian table
            try self.insertCivilian(name: name, email: email, phone: phone, userName: userName)
        }
        catch {
            print("Failed to insert registeredUserfromDb")
        }
    }
    
    
    func insertCivilian(name: String, email: String, phone: Int64, userName: String) throws {
        guard let DB = self.dbInstance.DB else {
            throw DataAccessError.datastore_Connection_Error
        }
        
        do
        {
            var query = "insert into MedNetUser (name, emailId, phoneNo) Values (?, ?, ?)"

            var stmt = try DB.prepare(query)
            try stmt.run(name, email, phone)
            self.id = DB.lastInsertRowid
            query = "insert into Registered (id, userName, userType) Values (?, ?, ?)"
            stmt = try DB.prepare(query)
            try stmt.run(self.id, userName, 1)
            
            //inserting data into Civilian class
            self.name = name
            self.emailId = emailId
            self.phoneNo = phone
            self.userName = userName
            
        }
        catch
        {
            throw DataAccessError.search_Error
        }
    }
    
        func insertCivilianID(cUID: String, cUIDType: String) {
            let DB = self.dbInstance.DB
            do {
                let query = "insert into Civilian(id, cUID, cUIDType) Values (?, ?, ?)"
                let stmt = try DB?.prepare(query)
                try stmt?.run(self.id, cUID, cUIDType)
                
                self.cUID = cUID
                self.cUIDType = CUIDType(rawValue: cUIDType)
                
            }
            catch {
                print("error inserting into civilian table")
            }
        }
    
    
        //successful data insertion

        
        
    }
    
    
    
    
    



