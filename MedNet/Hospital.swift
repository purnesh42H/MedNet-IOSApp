//
//  Hospital.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 4/1/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import Foundation

class Hospital : Registered {
    var specialService: Array<SpecialService> = Array()
    var hospitalServices = Set<String>()
    
    static let sharedInstance = Hospital()
    
    func getHospitalFromDb(userName: String) {
        //fetch from Resistered table
        getRegisteredFromDb(userName: userName)
        
        do {
            self.userName = userName
            //fetch from Civilian table
            try self.fetchHospital()
        }
        catch {
            print("Failed to fetch registeredUserfromDb")
        }
    }
    
    
    func fetchHospital() throws {
        guard let DB = self.dbInstance.DB else {
            throw DataAccessError.datastore_Connection_Error
        }
        do
        {
            let query = "select ms.id, msa.validTo, msa.authid, ha.name, s.name, hs.name  from Hospital c left outer join MedicalService ms on ms.userId = c.id  left outer join MedicalService_Authorization msa on msa.service = ms.id left outer join Special s on s.id = msa.service left outer join MedNetUser ha on ha.id = msa.authorizedBy left outer join HospitalServices hs on hs.providedBy = c.id where c.id = ?"
            let stmt = try DB.prepare(query)
            for row in try stmt.run(self.id)
            {
                //MedicalServices
                if(row[0] != nil) {
                    //organDonation construction
                    self.specialService.append(SpecialService(authorizedBy: row[3] as! String, authId: row[2] as! String, validTo: row[1] as! String, name: row[4] as! String))
                }
                
                if(row[5] != nil) {
                    //hospitalServices Construction
                    self.hospitalServices.insert(row[5] as! String)
                }
                
            }
            
            print("Successfully fetched Hospital data")
        }
        catch {
            throw DataAccessError.search_Error
        }
        //successful data extraction
    }
    
    func insertHospitalIntoDb(name: String, email: String, phone: Int64, userName: String) {
        do
        {
            let DB = self.dbInstance.DB
            var query = "insert into MedNetUser (name, emailId, phoneNo) Values (?, ?, ?)"
            var stmt = try DB?.prepare(query)
            try stmt?.run(name, email, phone)
            self.id = DB?.lastInsertRowid
            query = "insert into Registered (id, userName, userType) Values (?, ?, ?)"
            stmt = try DB?.prepare(query)
            try stmt?.run(self.id, userName, 4)
            
            self.name = name
            self.emailId = emailId
            self.phoneNo = phone
            self.userName = userName
        }
        catch
        {
            print("Insertion into MedNetUser and Registered table failed.")
        }
    }
    
    func insertHospitalServicesIntoDb(hospitalServicesList: [String]) {
        do {
            let DB = self.dbInstance.DB
            var query = "insert into Hospital(id) Values (?)"
            var stmt = try DB?.prepare(query)
            try stmt?.run(self.id)
            
            query = "insert into HospitalServices(providedBy, name) Values (?, ?)"
            for each in hospitalServicesList {
                stmt = try DB?.prepare(query)
                try stmt?.run(self.id, each)
            }
            
            self.hospitalServices = Set(hospitalServicesList)
        }
        catch {
            print("Failed to insert into Hospital and Hospital services tables")
        }
        
    } 
    
}




