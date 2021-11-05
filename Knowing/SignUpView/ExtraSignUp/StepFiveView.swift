//
//  ExtraSignFiveView.swift
//  Knowing
//
//  Created by Jun on 2021/11/03.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class StepFiveView: UIView {
    
    let cellId = "cellId"
    let disposeBag = DisposeBag()
    let score:[String] = ["선택 안함", "~2.99", "3.0~3.44", "3.5~3.99", "4.0~"]
    let schoolData:[[String]] = [["1", "2", "3", "4"],["학년"], ["1", "2"], ["학기"]]
    
    let semeLabel = UILabel().then {
        $0.text = "현재 학기"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let detailTextField:UITextField = {
       let tf = UITextField()
        let placeholder = NSMutableAttributedString(string: "1 ", attributes: [
            NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 19) ?? UIFont.systemFont(ofSize: 19),
            NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 194, green: 194, blue: 194)
        ])
        placeholder.append(NSMutableAttributedString(string: "학년   ", attributes: [
            NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 65, green: 65, blue: 65)
        ]))
        placeholder.append(NSMutableAttributedString(string: "1 ", attributes: [
            NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 19) ?? UIFont.systemFont(ofSize: 19),
            NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 194, green: 194, blue: 194)
        ]))
        placeholder.append(NSMutableAttributedString(string: "학기", attributes: [
            NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 65, green: 65, blue: 65)
        ]))
        tf.attributedPlaceholder = placeholder
        tf.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: tf.frame.size.height - 1, width: tf.frame.width, height: 1)
        border.backgroundColor = CGColor.init(red: 151 / 255, green: 151 / 255, blue: 151 / 255, alpha: 1.0)
        tf.layer.addSublayer(border)
        tf.bounds.inset(by: UIEdgeInsets(top: 4, left: 0, bottom: 11, right: 31))
        tf.rightView = UIImageView(image: UIImage(named: "triangle")!)
        tf.rightViewMode = .always
        return tf
    }()
    
    let detailPicker = UIPickerView()
    
    let checkBox = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
    }
    
    let deferredLabel = UILabel().then {
        $0.text = "추가 학기 / 졸업 유예"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        $0.textColor = UIColor.rgb(red: 115, green: 115, blue: 115)
    }
    
    let lastSemeLabel = UILabel().then {
        $0.text = "지난 학기 학점"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let scoreCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setCollectionView() {
        scoreCollectionView.dataSource = self
        scoreCollectionView.delegate = self
        scoreCollectionView.register(MajorCell.self, forCellWithReuseIdentifier: cellId)
        detailPicker.delegate = self
        detailPicker.dataSource = self
        detailTextField.inputView = detailPicker
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.tapCancel))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        detailTextField.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        detailTextField.resignFirstResponder()
    }
    
}

extension StepFiveView {
    func setUI() {
        addSubview(semeLabel)
        semeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(25)
        }
        
        addSubview(detailTextField)
        detailTextField.snp.makeConstraints {
            $0.top.equalTo(semeLabel.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(26)
            $0.width.equalTo(146)
        }
        
        addSubview(checkBox)
        checkBox.snp.makeConstraints {
            $0.top.equalTo(detailTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(17)
        }
        
        addSubview(deferredLabel)
        deferredLabel.snp.makeConstraints {
            $0.top.equalTo(detailTextField.snp.bottom).offset(22)
            $0.leading.equalTo(checkBox.snp.trailing).offset(3)
        }
        
        addSubview(lastSemeLabel)
        lastSemeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(deferredLabel.snp.bottom).offset(50)
        }
        
        addSubview(scoreCollectionView)
        scoreCollectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(lastSemeLabel.snp.bottom)
        }
        
        
        
    }
}

extension StepFiveView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 25, bottom: 267, right: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.frame.width - 92) / 3
        return CGSize(width: width, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return score.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MajorCell
        cell.button.setTitle(score[indexPath.item], for: .normal)
        return cell
    }
}

extension StepFiveView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return schoolData[component].count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return schoolData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var tmp1 = "2 학년   "
        var tmp2 = "2 학기"
        if component == 0 {
            tmp1 = "\(schoolData[component][row]) 학년  "
        }
        if component == 2 {
            tmp2 = "\(schoolData[component][row]) 학기"
        }
        
        detailTextField.text = tmp1 + tmp2
    }
    
}
