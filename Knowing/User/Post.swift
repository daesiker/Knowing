//
//  Post.swift
//  Knowing
//
//  Created by Jun on 2021/11/23.
//

import Foundation
import RxDataSources

struct Post: Codable {
    var uid:String = ""
    var name:String = ""
    var serviceType:String = ""
    var maxMoney:String = ""
    var minMoney:String = ""
    var incomeLevel:String = ""
    var category:String = ""
    var contents:String = ""
    var runDate:String = ""
    var applyDate:String = ""
    var scale:String = ""
    var age:String = ""
    var address:String = ""
    var detailTerms:String = ""
    var schoolrecords:String = ""
    var employmentState:String = ""
    var specialState:String = ""
    var joinLimit:String = ""
    var applyMethod:String = ""
    var judge:String = ""
    var url:String = ""
    var document:String = ""
    var manageOffice:String = ""
}

struct PostSectionModel {
    
    var header: [Post]
    var items: [Post]
    
    init() {
        self.header = []
        self.items = []
    }
    
}

extension PostSectionModel: SectionModelType {
    init(original: PostSectionModel, items: [Post]) {
        self = original
        self.items = items
    }
}
