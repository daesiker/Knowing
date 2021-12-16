//
//  User.swift
//  Knowing
//
//  Created by Jun on 2021/11/06.
//

import Foundation
import SwiftyJSON

struct User: Codable {
    //default
    var name:String = ""
    var email:String = ""
    var pwd:String = ""
    var gender:String = ""
    var birth:Int = 0
    var phNum:String = ""
    
    //step1
    var address:String = ""
    var addressDetail:String = ""
    var specialStatus:[String] = []
    
    //step2
    var incomeLevel:String = ""
    var incomeAvg:String = ""
    var employmentState:[String] = []
    
    //step3
    var schoolRecords:String = ""
    var school: String = ""
    
    //step4
    var mainMajor:String = ""
    var subMajor:String = ""
    
    //step5
    var semester:String = ""
    //var addSemester:Bool = false
    var lastSemesterScore:String = ""
    
    //category
    var studentCategory:[String] = []
    var empolyCategory:[String] = []
    var foundationCategory:[String] = []
    var residentCategory:[String] = []
    var lifeCategory:[String] = []
    var medicalCategory:[String] = []
   
    var bookmark:[String] = []
    var provider:String = ""
    var FCMTOKEN:String = ""
    var Alarm:[GetAlarm] = []
    
    init() {
        
    }
    
    init(json: [String:JSON]) {
        //default
        self.name = json["name"]?.string ?? "노잉"
        self.email = json["email"]!.stringValue
        self.pwd = json["pwd"]!.stringValue
        self.gender = json["gender"]!.stringValue
        self.birth = json["birth"]!.intValue
        self.phNum = json["phNum"]!.stringValue
        
        //step1
        self.address = json["address"]!.stringValue
        self.addressDetail = json["addressDetail"]!.stringValue
        self.specialStatus = json["specialStatus"]!.arrayValue.map { $0.stringValue }
        
        //step2
        self.incomeLevel = json["incomeLevel"]!.stringValue
        self.incomeAvg = json["incomeAvg"]!.stringValue
        self.employmentState = json["employmentState"]!.arrayValue.map { $0.stringValue }
        
        //step3
        self.schoolRecords = json["schoolRecords"]!.stringValue
        self.school = json["school"]!.stringValue
        
        //step4
        self.mainMajor = json["mainMajor"]!.stringValue
        self.subMajor = json["subMajor"]!.stringValue
        
        //step5
        self.semester = json["semester"]!.stringValue
        //var addSemester:Bool = false
        self.lastSemesterScore = json["lastSemesterScore"]!.stringValue
        
        //category
        self.studentCategory = json["studentCategory"]!.arrayValue.map { $0.stringValue }
        self.empolyCategory = json["empolyCategory"]!.arrayValue.map { $0.stringValue }
        self.foundationCategory = json["foundationCategory"]!.arrayValue.map { $0.stringValue }
        self.residentCategory = json["residentCategory"]!.arrayValue.map { $0.stringValue }
        self.lifeCategory = json["lifeCategory"]!.arrayValue.map { $0.stringValue }
        self.medicalCategory = json["medicalCategory"]!.arrayValue.map { $0.stringValue }
       
        self.bookmark = json["bookmark"]!.arrayValue.map { $0.stringValue }
        self.provider = json["provider"]!.stringValue
        self.FCMTOKEN = json["fcmtoken"]!.stringValue
        
    }
    
    func extraJson() -> [String:Any] {
        var dic:[String:Any] = [:]
        
        dic.updateValue(address, forKey: "address")
        dic.updateValue(addressDetail, forKey: "addressDetail")
        dic.updateValue(specialStatus, forKey: "specialStatus")
        dic.updateValue(incomeLevel, forKey: "incomeLevel")
        dic.updateValue(incomeAvg, forKey: "incomeAvg")
        dic.updateValue(employmentState, forKey: "employmentState")
        dic.updateValue(schoolRecords, forKey: "schoolRecords")
        dic.updateValue(school, forKey: "school")
        dic.updateValue(mainMajor, forKey: "mainMajor")
        dic.updateValue(subMajor, forKey: "subMajor")
        dic.updateValue(semester, forKey: "semester")
        dic.updateValue(lastSemesterScore, forKey: "lastSemesterScore")
        
        return dic
    }
    
    func checkAvailable() -> Bool {
        if address != "" && addressDetail != "" && specialStatus.count != 0 && incomeLevel != "" && incomeAvg != "" && employmentState.count != 0 && schoolRecords != ""{
            return true
        } else {
            return false
        }
    }
    
    func getUid() -> String {
        return UserDefaults.standard.string(forKey: "uid")!
    }
    
    
}
