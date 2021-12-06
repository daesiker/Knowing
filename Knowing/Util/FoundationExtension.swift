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
    
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        let quotient: Int
        let unit: String
        
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "초"
            return "\(quotient)\(unit) 전"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "분"
            return "\(quotient)\(unit) 전"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "시간"
            return "\(quotient)\(unit) 전"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "일"
            if quotient <= 7 {
                return "\(quotient)\(unit) 전"
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        return dateFormatter.string(from: self)
    }
    
    
}

extension Encodable {
    
    var toDictionary : [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String:Any] else { return nil }
        return dictionary
    }
}

func dictionaryToObject<T:Decodable>(objectType:T.Type,dictionary:[[String:Any]]) -> [T]? {
    
    guard let dictionaries = try? JSONSerialization.data(withJSONObject: dictionary) else { return nil }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    guard let objects = try? decoder.decode([T].self, from: dictionaries) else { return nil }
    return objects
    
}
