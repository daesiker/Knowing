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
    var password:String = ""
    var gender:String = ""
    var birth:String = ""
    var phNumber:String = ""
    
    //step1
    var address:String = ""
    var specialStatus:[String] = []
    
    
    
    var school: String? = nil
    var major: String? = nil
    var score: String? = nil
    var currentTerm: String? = nil
    
    var category:[[String]] = [[], [], [], [], []]
    
    var provider:String = ""
    var fcmToken:String = ""
}
