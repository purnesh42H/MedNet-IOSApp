//
//  Doctor.swift
//  SQLite
//
//  Created by Himanshi Bhardwaj on 4/1/17.
//
//

import Foundation

class Doctor : Registered {
    var specializations = Set<String>()
    var degrees = Set<String>()
    var hospitals = Set<String>()
    
    static var sharedInstance = Doctor()
    
    func getDoctorFromDb(userName: String) {
        //fetch from Resistered table
        getRegisteredFromDb(userName: userName)
        
        do {
            self.userName = userName
            //fetch from Doctor table
            try self.fetchProfileHospitalAppointmentAndDonations(userType: "Doctor")
            try self.fetchDoctor()
        }
        catch {
            print("Failed to fetch registeredUserfromDb")
        }
    }
    
    func fetchDoctor() throws {
        guard let DB = self.dbInstance.DB else {
            throw DataAccessError.datastore_Connection_Error
        }
        
        do
        {
            let query = "select hpt.name, s.name, dg.name from Doctor d left outer join Hospital_Doctors hd on hd.has = d.id left outer join MedNetUser hpt on hpt.id = hd.worksIn left outer join Specialization s on s.of = d.id left outer join Degree dg on dg.of = d.id where d.id = ?"
            let stmt = try DB.prepare(query)
            for row in try stmt.run(self.id)
            {
                if(row[0] != nil) {
                    //allergies Construction
                    self.hospitals.insert(row[0] as! String)
                }
                if(row[1] != nil) {
                    //interestsSet Construction
                    self.specializations.insert(row[1] as! String)
                }
                if(row[2] != nil) {
                    //treatment Construction
                    self.degrees.insert(row[2] as! String)
                }
            }
            
            print("Successfully fetched Doctor data")
        }
        catch
        {
            throw DataAccessError.search_Error
        }
        //successful data extraction
    }
    
    func insertDoctorIntoDb(name: String, email: String, phone: Int64, userName: String) {
        do
        {
            let DB = self.dbInstance.DB
            var query = "insert into MedNetUser (name, emailId, phoneNo) Values (?, ?, ?)"
            var stmt = try DB?.prepare(query)
            try stmt?.run(name, email, phone)
            self.id = DB?.lastInsertRowid
            query = "insert into Registered (id, userName, userType) Values (?, ?, ?)"
            stmt = try DB?.prepare(query)
            try stmt?.run(self.id, userName, 2)
            
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
    
    func insertDegreesIntoDoctor(degreeList: [String]) {
        do {
            let DB = self.dbInstance.DB
            var query = "insert into Doctor(id) Values (?)"
            var stmt = try DB?.prepare(query)
            try stmt?.run(self.id)
            
            query = "insert into Degree(of, name) Values(?, ?)"
            for each in degreeList {
            stmt = try DB?.prepare(query)
            try stmt?.run(self.id, each)
            }
            
            self.degrees = Set(degreeList)
        }
        catch {
            print("Failed to insert into Doctor and Degree tables")
        }
    
    }
    
}



