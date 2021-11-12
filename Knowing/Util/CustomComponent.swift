//
//  CustomComponent.swift
//  Knowing
//
//  Created by Jun on 2021/10/22.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String) {
        self.init()
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 27.0
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class CustomTextField: UITextField {
    
    var isLogin:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: UIImage, text: String, isLogin: Bool = false) {
        self.init()
        self.isLogin = isLogin
        self.backgroundColor = isLogin ? UIColor.rgb(red: 243, green: 243, blue: 243) : UIColor.white
        self.placeholder = text
        self.layer.cornerRadius = 20.0
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
        self.delegate = self
        self.setLeft(image: image)
        self.setRight()
            
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 12, left: 40, bottom: 13, right: 40))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets.init(top: 12, left: 9, bottom: 13, right: 9))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets.init(top: 12, left: 9, bottom: 13, right: 9))
    }
    
}

extension CustomTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.isLogin {
            self.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
        } else {
            self.backgroundColor = UIColor.rgb(red: 255, green: 236, blue: 210)
            self.layer.borderColor = CGColor(red: 255 / 255, green: 142 / 255, blue: 59 / 255, alpha: 1.0)
            self.layer.borderWidth = 1.0
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.isLogin {
            self.backgroundColor = UIColor.rgb(red: 243, green: 243, blue: 243)
        } else {
            self.backgroundColor = .white
            self.borderStyle = .none
            self.layer.borderColor = .none
            self.layer.borderWidth = 0.0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


class CustomPicker: UIButton {
    
    let label = UILabel().then {
        $0.text = ""
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        $0.textColor = UIColor.rgb(red: 194, green: 194, blue: 194)
    }
    
    let image = UIImageView(image: UIImage(named: "triangle")!)
    
    let border = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 151, green: 151, blue: 151)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(border)
        border.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-9)
        }
        
        self.addSubview(image)
        image.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(9)
            $0.bottom.equalToSuperview().offset(-11)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ text: String) {
        self.init()
        label.text = text
    }
    
}
