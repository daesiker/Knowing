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
    
    var useState:TextFieldState = .signUp
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: UIImage, text: String, state: TextFieldState = .signUp) {
        self.init()
        self.useState = state
        self.backgroundColor = state == .signUp ? .white : UIColor.rgb(red: 243, green: 243, blue: 243)
        self.placeholder = text
        self.layer.cornerRadius = 20.0
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
        self.delegate = self
        self.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
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
        
        switch useState {
        case .login:
            self.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
        case .signUp:
            self.backgroundColor = UIColor.rgb(red: 255, green: 236, blue: 210)
            self.layer.borderColor = CGColor(red: 255 / 255, green: 142 / 255, blue: 59 / 255, alpha: 1.0)
            self.layer.borderWidth = 1.0
        case .search:
            break
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch useState {
        case .login:
            self.backgroundColor = UIColor.rgb(red: 243, green: 243, blue: 243)
        case .signUp:
            self.backgroundColor = .white
            self.borderStyle = .none
            self.layer.borderColor = .none
            self.layer.borderWidth = 0.0
        default:
            break
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
            $0.height.equalTo(0.5)
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

class HomeAllPostBt: UIButton {
    
    let title = UILabel().then {
        $0.text = ""
        $0.textColor = UIColor.rgb(red: 205, green: 153, blue: 117)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
    }
    
    let border = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 199, blue: 143)
        $0.layer.cornerRadius = 3.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        title.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(border)
        border.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        bringSubviewToFront(title)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ text: String) {
        self.init()
        title.text = text
    }
    
    
    
}

class PaddingLabel: UILabel {
    
    var topInset: CGFloat = 8.0
    var bottomInset: CGFloat = 8.0
    var leftInset: CGFloat = 10.0
    var rightInset: CGFloat = 10.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}

