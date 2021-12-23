//
//  UIKitExtension.swift
//  Knowing
//
//  Created by Jun on 2021/10/15.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
extension UIViewController {
    
    func lightMode(){
        if #available(iOS 13.0, *) {
            // Always adopt a light / dark interface style.
            overrideUserInterfaceStyle = .light // 상태바는 검은글씨, 흰배경
            setNeedsStatusBarAppearanceUpdate()
            
        }
        
    }
    
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
    
    func keyBoardAction() {
        
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
        let wrapperView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 31, height: 21))
        let imageView = UIImageView(frame: CGRect.init(x: 10, y: 0, width: 21, height: 21))
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        wrapperView.addSubview(imageView)
        
        leftView = wrapperView
        leftViewMode = .always
        
    }
    
    func setErrorRight() {
        let wrapperView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: bounds.height, height: bounds.height))
        let imageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 21, height: 20))
        
        imageView.image = UIImage(named: "tfAlert")
        imageView.contentMode = .scaleAspectFit
        wrapperView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        rightView = wrapperView
        rightViewMode = .always
        
    }
    
    func setRight() {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(named: "tfCancel")!, for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        clearButton.addTarget(self, action: #selector(UITextField.clear), for: .touchUpInside)
        self.addTarget(self, action: #selector(UITextField.displayClearButtonIfNeeded), for: .editingDidBegin)
        self.addTarget(self, action: #selector(UITextField.displayClearButtonIfNeeded), for: .editingChanged)
        self.rightView = clearButton
        self.rightViewMode = .whileEditing
    }
    
    @objc private func displayClearButtonIfNeeded() {
        self.rightView?.isHidden = (self.text?.isEmpty) ?? true
    }
    
    @objc private func clear(sender: AnyObject) {
        self.text = ""
        sendActions(for: .editingChanged)
    }
    
    var datePicker: UIDatePicker {
        get {
            let SCwidth = self.bounds.width
            let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: SCwidth, height: 216))
            datePicker.datePickerMode = .date
            datePicker.isSelected = true
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
                datePicker.setValue(UIColor.black, forKey: "textColor")
            }
            return datePicker
        }
    }
    
    func setDatePicker(target: Any) {
        
        self.inputView = datePicker
        let SCwidth = self.bounds.width
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: SCwidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: #selector(donePressed))
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
        
    }
    
    @objc func donePressed(_ sender: UIDatePicker) {
        if let datePicker = self.inputView as? UIDatePicker {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "yyyy / MM / dd"
            let strDate = dateFormater.string(from: datePicker.date)
            self.text = strDate
        }
        
        self.resignFirstResponder()
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}

extension UITabBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 56 // 원하는 길이
        return sizeThatFits
    }
    
}

extension UIScrollView {
    func updateContentSize() {
        let unionCalculatedTotalRect = recursiveUnionInDepthFor(view: self)
        
        // 계산된 크기로 컨텐츠 사이즈 설정
        self.contentSize = CGSize(width: self.frame.width, height: unionCalculatedTotalRect.height+30)
    }
    
    private func recursiveUnionInDepthFor(view: UIView) -> CGRect {
        var totalRect: CGRect = .zero
        
        // 모든 자식 View의 컨트롤의 크기를 재귀적으로 호출하며 최종 영역의 크기를 설정
        for subView in view.subviews {
            totalRect = totalRect.union(recursiveUnionInDepthFor(view: subView))
        }
        
        // 최종 계산 영역의 크기를 반환
        return totalRect.union(view.frame)
    }
}

@IBDesignable class VerticalProgressView : UIView {
    @IBInspectable public var animationDuration = 2.0
    var previousProgress : Float = 0.0
    @IBInspectable public var progress:Float {
        get {
            return self.previousProgress
        }
        set {
            self.setProgress(progress: newValue, animated: self.animationDuration > 0.0)
        }
    }
    public var color: CGColor?
    
    public var filledView:CALayer?
    
    
    
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        let filledHeight = rect.size.height * CGFloat(self.previousProgress)
        let y = self.frame.size.height - filledHeight
        self.filledView!.frame = CGRect(x: 0, y: y, width: rect.size.width, height: rect.size.height)
        self.filledView?.cornerRadius = 10
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        if self.filledView == nil {
            self.filledView = CALayer()
            self.filledView!.backgroundColor = color!
            self.layer.addSublayer(filledView!)
        }
        self.filledView!.frame = self.bounds
        self.filledView!.frame.origin.y = self.getPosition()
    }
    
    public override func prepareForInterfaceBuilder() {
        self.previousProgress = progress
        if self.previousProgress < 0 { previousProgress = 0 }
        else if(self.previousProgress > 1) { previousProgress = 1}
    }
    
    public func setProgress(progress:Float,animated: Bool){
        
        var value = progress
        if (value < 0.0){
            value = 0.0
        }
        else if(value > 1.0){
            value = 1.0
        }
        
        self.previousProgress = value
        setFilledProgress(position: getPosition(),animated:animated)
    }
    
    fileprivate func setFilledProgress(position:CGFloat, animated:Bool) {
        if self.filledView == nil { return }
        //animated
        let duration: TimeInterval = animated ? self.animationDuration : 0;
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        self.filledView!.frame.origin.y = position
        CATransaction.commit()
    }
    
    fileprivate func getPosition() -> CGFloat {
        let filledHeight = self.frame.size.height * CGFloat(self.previousProgress)
        let position = self.frame.size.height - filledHeight
        return position
    }
}

extension UIImage {
    
    func getLogoImage(_ string:String) -> UIImage? {
        
        switch string {
        case "중소벤처기업진흥공단":
            return UIImage(named: "KsmeLogo")
        case "한국토지주택공사", "LH 주거급여 콜센터":
            return UIImage(named: "LHLogo")
        default:
            return UIImage(named: "goLogo")
            
        }
        
        
    }
    
}

extension UIView {
    
    func getHeight() -> CGFloat {
        let unionCalculatedTotalRect = recursiveUnionInDepthFor(view: self)
        
        // 계산된 크기로 컨텐츠 사이즈 설정
        return unionCalculatedTotalRect.height
    }
    
    private func recursiveUnionInDepthFor(view: UIView) -> CGRect {
        var totalRect: CGRect = .zero
        
        // 모든 자식 View의 컨트롤의 크기를 재귀적으로 호출하며 최종 영역의 크기를 설정
        for subView in view.subviews {
            totalRect = totalRect.union(recursiveUnionInDepthFor(view: subView))
        }
        
        // 최종 계산 영역의 크기를 반환
        return totalRect.union(view.frame)
    }
    
}
