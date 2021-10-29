//
//  UIKitExtension.swift
//  Knowing
//
//  Created by Jun on 2021/10/15.
//

import Foundation
import UIKit

extension UIViewController {
    
    var safeArea:UIView {
        get {
            guard let safeArea = self.view.viewWithTag(Int(INT_MAX)) else {
                let guide = self.view.safeAreaLayoutGuide
                let view = UIView()
                view.tag = Int(INT_MAX)
                self.view.addSubview(view)
                view.snp.makeConstraints {
                    $0.edges.equalTo(guide)
                }
                return view
            }
            return safeArea
        }
    }
    
}

extension UIColor {
    static let mainColor = UIColor(named: "mainColor")
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}



extension NSAttributedString {
    func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {


        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }
}

extension UITextField {
    
    func setLeft(image: UIImage, withPadding padding: CGFloat = 0) {
        let wrapperView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: bounds.height, height: bounds.height))
        
        let imageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 21, height: 20))
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        wrapperView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(11)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        leftView = wrapperView
        leftViewMode = .always
        
    }
    
    func setDatePicker(target: Any, selector: Selector) {
        let SCwidth = self.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: SCwidth, height: 216))
        datePicker.datePickerMode = .date
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: SCwidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
        
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
    
}
