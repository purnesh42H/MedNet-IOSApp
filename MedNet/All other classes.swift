//
//  All other classes.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/29/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import Foundation

//Enumerations
enum Status: String {
    case Canceled = "Canceled"
    case Pending = "Pending"
    case Completed = "Completed"
    case Denied = "Denied"
}

enum RequestType: String {
    case Manual = "Manual"
    case System = "System"
}

enum CUIDType: String {
    case StateId = "State Id"
    case Passport = "Passport"
    case DrivingLicence = "Driving Licence"
}

enum UserType: String {
    case Civilian = "Civilian"
    case Doctor = "Doctor"
    case Hospital = "Hospital"
    case VolunteerOrganization = "VolunteerOrganization"
}

enum BloodType: String {
    case AP = "A+"
    case AN = "A-"
    case ABP = "AB+"
    case ABN = "AB-"
    case OP = "O+"
    case ON = "O-"
    case BP = "B+"
    case BN = "B-"
}

//All classes
class MedicalRequest {
    var requestId: Int64?
    var reason: String?
    var requestType: RequestType?
    var status: Status?
    
    init (requestId: Int64, reason: String, requestType: String, status: String) {
        self.requestId = requestId
        self.reason = reason
        //self.requestType = requestType
        //self.status = status
        print("requestType:", requestType)
        print("status:", status)
        self.requestType = RequestType(rawValue: requestType)
        self.status = Status(rawValue: status)
    }
}

class UnRegisteredMedNetUser: MedNetUser {
}

class Government: UnRegisteredMedNetUser {
}

class HealthAccrediationAuthority: UnRegisteredMedNetUser {
    var authorizedBy: Government?
}

class Other: UnRegisteredMedNetUser {
    var connectedTo: Array<Registered> = Array()
}

class Profile {
    var approval: Status?
    var bloodType: BloodType?
    var dateOfBirth: String?
    
    var interestsSet = Set<String>()
    var treatmentSet = Set<String>()
    var certificatesSet = Set<String>()
    var allergiesSet = Set<String>()
    
    
    init(approval: String, bloodType: String, dateOfBirth: String) {
        self.approval = Status(rawValue: approval)
        self.bloodType = BloodType(rawValue: bloodType)
        self.dateOfBirth = dateOfBirth
    }
}

class MedicalService {
    var authorizedBy: String?
    var authId: String?
    var validTo: String?
    init(authorizedBy: String, authId: String, validTo: String) {
        self.authorizedBy = authorizedBy
        self.authId = authId
        self.validTo = validTo
    }
}

class Donation: MedicalService {
    override init(authorizedBy: String, authId: String, validTo: String) {
        super.init(authorizedBy: authorizedBy, authId: authId, validTo: validTo)
    }
}

class SpecialService : MedicalService {
    var name: String?
    init(authorizedBy: String, authId: String, validTo: String, name: String) {
        super.init(authorizedBy: authorizedBy, authId: authId, validTo: validTo)
        self.name = name
    }
}

class FundDonation: Donation {
    var fundLimit: Double?
    init(authorizedBy: String, authId: String, validTo: String, fundLimit: Double) {
        super.init(authorizedBy: authorizedBy, authId: authId, validTo: validTo)
        self.fundLimit = fundLimit
    }
}

class OrganDonation : Donation {
    var name: String?
    init(authorizedBy: String, authId: String, validTo: String, name: String) {
        super.init(authorizedBy: authorizedBy, authId: authId, validTo: validTo)
        self.name = name
    }
}

class HospitalAppointment {
    var hospitalName: String?
    var appointmentId: Int64?
    var date: String?
    var reason: String?
    var start: String?
    var end: String?
    
    init(hospitalName: String, appointmentId: Int64, date: String, reason: String, start: String, end: String) {
        self.hospitalName = hospitalName
        self.appointmentId = appointmentId
        self.date = date
        self.reason = reason
        self.start = start
        self.end = end
    }
    
    
}
