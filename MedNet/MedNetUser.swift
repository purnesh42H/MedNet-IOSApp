//
//  MedNetUser.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/31/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import Foundation
import SQLite


class MedNetUser {
    var id: Int64?
    var name: String?
    var emailId: String?
    var phoneNo: Int64?
    var sentRequests: Array<MedicalRequest> = Array()
    var receivedRequests: Array<MedicalRequest> = Array()
    var dbInstance: SQLiteDataStore
    
    init() {
        self.dbInstance = SQLiteDataStore.sharedInstance
        
    }
    
    func getMedNetUserFromDb(id: Int64) {
        do {
            self.id = id
            try self.fetchMedNetUser()
        }
        catch {
            print("Failed to fetch user")
        }
    }
    
    func fetchMedNetUser() throws {
        guard let DB = self.dbInstance.DB else {
            throw DataAccessError.datastore_Connection_Error
        }
        
        do
        {
            UserProfile.sharedInstance.placedMedicalRequests = []
            UserProfile.sharedInstance.incomingMedicalRequests = []
            var medicalRequestsList: [Int64] = []
            
            var query = "select u.id, u.name, u.emailId, u.phoneNo, s_rq.id, s_rq.reason, s_rq.requestType, s_rq.status, r_rq.id, r_rq.reason, r_rq.status, r_rq.requestType from MedNetUser u left outer join MedicalRequest s_rq on s_rq.placedBy = u.id left outer join MedicalRequest_MedNetUser mrq on mrq.placedTo = u.id left outer join MedicalRequest r_rq on r_rq.id = mrq.have where u.id = ?"
            var stmt = try DB.prepare(query)
            for row in try stmt.run(self.id)
            {
                print("row:", row)
                self.id = row[0] as? Int64
                self.name = row[1] as? String
                self.emailId = row[2] as? String
                self.phoneNo = row[3] as? Int64
                if (row[4] != nil) && !(medicalRequestsList.index(of: (row[4] as? Int64)!) != nil) {
                    
                self.sentRequests.append(MedicalRequest(requestId: (row[4] as? Int64)!,
                                                        reason: (row[5] as? String)!,
                                                        requestType: getRequestType(requestTypeInt: (row[6] as? Int64)!),
                                                        status: getStatus(statusInt: (row[7] as? Int64)!)))
                    medicalRequestsList.append((row[4] as? Int64)!)
                }
                
                if (row[8] != nil) && !(medicalRequestsList.index(of: (row[8] as? Int64)!) != nil) {
                self.receivedRequests.append(MedicalRequest(requestId: (row[8] as? Int64)!, reason: (row[9] as? String)!, requestType: getRequestType(requestTypeInt: (row[10] as? Int64)!), status: getStatus(statusInt: (row[11] as? Int64)!)))
                    medicalRequestsList.append((row[8] as? Int64)!)
                }

            }
            //Adding data to UserProfile
            UserProfile.sharedInstance.placedMedicalRequests.insert(contentsOf: sentRequests, at: 0)
            UserProfile.sharedInstance.incomingMedicalRequests.insert(contentsOf: receivedRequests, at: 0)
        }
        catch
        {
            throw DataAccessError.search_Error
        }
        
        
    }//end of func fetchUser()
    
    func getStatus(statusInt: Int64) -> String {
        switch(Int(statusInt)) {
        case 1: return "Canceled"
        case 2: return "Pending"
        case 3: return "Denied"
        case 4: return "Completed"
        default: return "Pending"
        }
    }
    
    func getRequestType(requestTypeInt: Int64) -> String {
        switch(Int(requestTypeInt)) {
        case 1: return "Manual"
        case 2: return "System"
        default: return "Manual"
        }
    }
    
    //just to test
    func printMedNet() {
        print("id", id)
        print("name", name)
        print("emailId", emailId)
        print("phoneNo", phoneNo)
        print("sentRequests", sentRequests)
        print("receivedRequests", receivedRequests)
    }//end of func printMedNet()
    
    
    
    
    
    
}
