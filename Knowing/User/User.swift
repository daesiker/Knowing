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
    var money1:String = ""
    var money2:String = ""
    var employStatus:[String] = []
    
    //step3
    var records:[String] = []
    
    var school: String? = nil
    var major: String? = nil
    var score: String? = nil
    var currentTerm: String? = nil
    
    var category:[[String]] = [[], [], [], [], []]
    
    var provider:String = ""
    var fcmToken:String = ""
}
