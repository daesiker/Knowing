//
//  Category.swift
//  Knowing
//
//  Created by Jun on 2021/11/30.
//

import Foundation

struct Category: Codable {
    
    var studentCategory:[String]
    var employCategory:[String]
    var foundationCategory:[String]
    var residentCategory:[String]
    var lifeCategory:[String]
    var medicalCategory:[String]
    
    init(dic: [String:[String]]) {
        self.studentCategory = dic["studentCategory"] ?? []
        self.employCategory = dic["employCategory"] ?? []
        self.residentCategory = dic["residentCategory"] ?? []
        self.foundationCategory = dic["foundationCategory"] ?? []
        self.lifeCategory = dic["lifeCategory"] ?? []
        self.medicalCategory = dic["medicalCategory"] ?? []
    }
    
    
    
}
