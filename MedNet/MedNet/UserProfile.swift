//
//  UserProfile.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/26/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import Foundation

class UserProfile {
    static var sharedInstance = UserProfile()
    var userType = ""

    var approvedStatus: String?
    var userId: String?
    var userName: String?
    var firstName: String?
    var lastName: String?
    var phoneNo: Int64?
    var placedMedicalRequests : Array<MedicalRequest> = Array()
    var incomingMedicalRequests: Array<MedicalRequest> = Array()
    var hospitalAppointments: [HospitalAppointment?] = []
    var fundDonations: [FundDonation?] = []
    var organDonations: [OrganDonation?] = []
    var approval: Status?
    var bloodType: BloodType?
    var dateOfBirth: Date?
    var interests: [String?] = []
    var treatments: [String?] = []
    var certificates: [String?] = []
    var allergies: [String?] = []
    var donations: [(String, String)] = []
    
    /*init() {
        firstName = ""
        lastName = ""
        phoneNo = nil
        dateOfBirth = nil
        bloodType = nil
        allergies = []
        treatments = []
        certificates = []
        placedMedicalRequests = []
        incomingMedicalRequests = []
    }*/
    
    func addANewUser(firstName: String?, lastName: String?, phoneNo: Int64?,
                     dateOfBirth: Date?, bloodType: BloodType?, allergies: [String?],
                     treatments: [String?], certificates: [String?], medicalRequests: [MedicalRequest]) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNo = phoneNo
        self.dateOfBirth = dateOfBirth
        self.bloodType = bloodType
        self.allergies = allergies
        self.treatments = treatments
        self.certificates = certificates
        self.placedMedicalRequests = medicalRequests
        self.approvedStatus = "Pending"
        
    }
    
    /*init(firstName: String?, lastName: String?, phoneNo: Int64?,
         dateOfBirth: Date?, bloodType: BloodType?, allergies: [String?],
         treatments: [String?], certificates: [String?], medicalRequests: [MedicalRequest]) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNo = phoneNo
        self.dateOfBirth = dateOfBirth
        self.bloodType = bloodType
        self.allergies = allergies
        self.treatments = treatments
        self.certificates = certificates
        self.placedMedicalRequests = medicalRequests
        self.approvedStatus = "Pending"
    }*/
    
    //getters
    func getDateOfBirth() -> Date {
        return dateOfBirth!
    }
    
    func getBloodType() -> BloodType {
        return bloodType!
    }
    
    func getAllergies() -> [String] {
        return allergies as! [String]
    }
    
    func getTreatments() -> [String] {
        return treatments as! [String]
    }
    
    func getCertificates() -> [String] {
        return certificates as! [String]
    }
    
    func getMedicalRequests() -> [MedicalRequest] {
        return placedMedicalRequests as! [MedicalRequest]
    }
    

    //setters
    func setDateOfBirth(dateOfBirth: Date) {
        self.dateOfBirth = dateOfBirth
    }
    
    func setBloodType(bloodType: BloodType) {
        self.bloodType = bloodType
    }
    
    func setAllergies(allergies: [String]) {
        self.allergies = allergies
    }
    
    func setTreatments(treatments: [String]) {
        self.treatments = treatments
    }
    
    func setCertificates(certificates: [String]) {
        self.certificates = certificates
    }
    
    func addMedicalRequest(status: String, requestType: String, reason: String) {
        //let r = RequestType(rawValue: requestType)!
        //let s = Status(rawValue: status)!
        self.placedMedicalRequests.append(MedicalRequest(requestId: 1, reason: reason, requestType: requestType, status: status))
    }
    
}
