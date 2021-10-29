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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: UIImage, text: String, isSecure: Bool = false) {
        self.init()
        self.backgroundColor = UIColor.white
        self.placeholder = text
        self.layer.cornerRadius = 20.0
        self.isSecureTextEntry = isSecure
        
        
        
        self.setLeft(image: image)
        
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets.init(top: 12, left: 40, bottom: 13, right: 40))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets.init(top: 12, left: 40, bottom: 13, right: 40))
    }
    
    
}
