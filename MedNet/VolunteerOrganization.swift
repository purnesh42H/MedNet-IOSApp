//
//  VolunteerOrganization.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 4/1/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import Foundation

class VolunteerOrganization : Registered {
    static let sharedInstance = VolunteerOrganization()
    
    func getVolunteerOrganizationFromDb(userName: String) {
        //fetch from Resistered table
        getRegisteredFromDb(userName: userName)
        
        do {
            self.userName = userName
            //fetch from Civilian table
            try self.fetchVolunteer()
        }
        catch {
            print("Failed to fetch registeredUserfromDb")
        }
    }
    
    
    func fetchVolunteer() throws {
        guard let DB = self.dbInstance.DB else {
            throw DataAccessError.datastore_Connection_Error
        }
        do
        {
            let query = "select ms.id, msa.validTo, msa.authid, ha.name, o.name, f.fLimit from Hospital c left outer join MedicalService ms on ms.userId = c.id  left outer join MedicalService_Authorization msa on msa.service = ms.id left outer join Fund f on f.id = msa.service left outer join MedNetUser ha on ha.id = msa.authorizedBy left outer join Organ o on o.id = msa.service where c.id = ?"
            let stmt = try DB.prepare(query)
            for row in try stmt.run(self.id)
            {//MedicalServices
                if(row[0] != nil) {
                    //organDonation construction
                    if(row[4] != nil) {
                        self.organDonation.append(OrganDonation(authorizedBy: row[3] as! String, authId: row[2] as! String, validTo: row[1] as! String, name: row[4] as! String))
                    }
                    //fundDonation construction
                    if (row[5] != nil) {
                        self.fundDonation.append(FundDonation(authorizedBy: row[3] as! String, authId: row[2] as! String, validTo: row[1] as! String, fundLimit: row[5] as! Double))
                    }
                }

                
            }
            
            print("Successfully fetched Volunteer organization data")
        }
        catch {
            throw DataAccessError.search_Error
        }
        //successful data extraction
    }
    
    
    func insertVolunteerOrganizationIntoDb(name: String, email: String, phone: Int64, userName: String) {
        do
        {
            let DB = self.dbInstance.DB
            var query = "insert into MedNetUser (name, emailId, phoneNo) Values (?, ?, ?)"
            var stmt = try DB?.prepare(query)
            try stmt?.run(name, email, phone)
            self.id = DB?.lastInsertRowid
            query = "insert into Registered (id, userName, userType) Values (?, ?, ?)"
            stmt = try DB?.prepare(query)
            try stmt?.run(self.id, userName, 3)
            
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
    
    
    
    
}




