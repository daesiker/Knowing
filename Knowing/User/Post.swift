//
//  Post.swift
//  Knowing
//
//  Created by Jun on 2021/11/23.
//

import Foundation
import SwiftyJSON

struct Post: Codable {
    
    var manageOffice:String = ""
    var incomeLevel:String = ""
    var detailTerms:String = ""
    var schoolRecords:String = ""
    var url:String = ""
    var title:String = ""
    var scale:String = ""
    var age:String = ""
    var name:String = ""
    var employmentState:String = ""
    var specialStatus:String = ""
    var applyMethod:String = ""
    var address:String = ""
    var document:String = ""
    var minMoney:String = ""
    var uid:String = ""
    var phNum:String = ""
    var applyDate:String = ""
    var serviceType:String = ""
    var joinLimit:String = ""
    var content:String = ""
    var judge:String = ""
    var category:String = ""
    var runDate:String = ""
    var maxMoney:String = ""

    init(json: JSON) {
        self.manageOffice = json["manageOffice"].stringValue
        self.incomeLevel = json["incomeLevel"].stringValue
        self.detailTerms = json["detailTerms"].stringValue
        self.schoolRecords = json["schoolRecords"].stringValue
        self.url = json["url"].stringValue
        self.title = json["title"].stringValue
        self.scale = json["scale"].stringValue
        self.age = json["age"].stringValue
        self.name = json["name"].stringValue
        self.employmentState = json["employmentState"].stringValue
        self.specialStatus = json["specialStatus"].stringValue
        self.applyMethod = json["applyMethod"].stringValue
        self.address = json["address"].stringValue
        self.document = json["document"].stringValue
        self.minMoney = json["minMoney"].stringValue
        self.uid = json["uid"].stringValue
        self.phNum = json["phNum"].stringValue
        self.applyDate = json["applyDate"].stringValue
        self.serviceType = json["serviceType"].stringValue
        self.joinLimit = json["joinLimit"].stringValue
        self.content = json["content"].stringValue
        self.judge = json["judge"].stringValue
        self.category = json["category"].stringValue
        self.runDate = json["runDate"].stringValue
        self.maxMoney = json["maxMoney"].stringValue
    }
    
    
}

