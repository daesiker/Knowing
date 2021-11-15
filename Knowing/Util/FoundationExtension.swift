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
    
    //숫자+문자 포함해서 8~20글자 사이의 text 체크하는 정규표현식
    func validpassword() -> Bool {
        let passwordreg = ("(?=.*[A-Za-z])(?=.*[0-9]).{8,20}")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: self)
    }

}

extension Date {
    var age:Int { Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
}
