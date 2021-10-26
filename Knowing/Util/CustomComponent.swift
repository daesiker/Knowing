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
        self.backgroundColor = UIColor.mainColor
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
        self.borderStyle = .roundedRect
        self.placeholder = text
        self.layer.cornerRadius = 20.0
        self.isSecureTextEntry = isSecure
        
        self.leftViewMode = UITextField.ViewMode.always
        let leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftImageView.image = image
        self.leftView = leftImageView
        
        self.rightViewMode = UITextField.ViewMode.always
        let rightImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let rightImage = UIImage(systemName: "exclamationmark.circle.fill")
        rightImageView.image = rightImage
        self.rightView = rightImageView
        
    }
    
    
    
}
