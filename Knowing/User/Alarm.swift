//
//  Alarm.swift
//  Knowing
//
//  Created by Jun on 2021/12/02.
//

import Foundation
import SwiftyJSON

struct GetAlarm:Codable {
    var uid:String = ""
    var title:String = ""
    var subTitle:String = ""
    var date:String = ""
    var postUid:String = ""
    var isRead:String = ""
    
    init() {}
    
    init(json: JSON) {
        self.uid = json["uid"].stringValue
        self.title = json["title"].stringValue
        self.subTitle = json["subTitle"].stringValue
        self.date = json["date"].stringValue
        self.postUid = json["postUid"].stringValue
        self.isRead = json["isRead"].stringValue
    }
}

struct GetAlarmList: Codable {
    
    var uid:String = ""
    var title:String = ""
    var subTitle:String = ""
    var date:String = ""
    var postUid:String = ""
    var alarmRead:Bool = false
    
    init() {}
    
    init(json: JSON) {
        self.uid = json["uid"].stringValue
        self.title = json["title"].stringValue
        self.subTitle = json["subTitle"].stringValue
        self.date = json["date"].stringValue
        self.postUid = json["postUid"].stringValue
        self.alarmRead = json["alarmRead"].boolValue
    }
    
}

