//
//  FoundationExtension.swift
//  Knowing
//
//  Created by Jun on 2021/11/02.
//

import Foundation

extension String {
    
    func nameMatchString(_ string: String) -> Bool {
        let strArr = Array(string)
        let pattern = "^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]$"
        
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            for str in strArr {
                if regex.matches(in: String(str), options: [], range: NSRange(location: 0, length: 1)).count == 0 {
                    return false
                }
            }
        }
        return true
    }
    
}
