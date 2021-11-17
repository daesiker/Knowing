//
//  User.swift
//  Knowing
//
//  Created by Jun on 2021/11/06.
//

import Foundation

struct User {
    //default
    var name:String = ""
    var email:String = ""
    var pwd:String = ""
    var gender:Bool = true
    var birth:Int = 0
    var phNumber:String = ""
    
    //step1
    var address:String = ""
    var specialStatus:[String] = []
    
    //step2
    var incomeLevel:String = ""
    var incomeAvg:String = ""
    var employmentState:[String] = []
    
    //step3
    var schollRecords:[String] = []
    var school: String? = nil
    
    //step4
    var mainMajor:String = ""
    var subMajor:String = ""
    
    //step5
    var semester:String = ""
    var addSemester:Bool = false
    var lastSemesterScore:String = ""
    
    
    
    var category:[[String]] = [[], [], [], [], []]
    var bookmark:String = ""
    var provider:String = ""
    var fcmToken:String = ""
}
