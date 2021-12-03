//
//  ExtraSignTwoView.swift
//  Knowing
//
//  Created by Jun on 2021/11/03.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class StepTwoView: UIView {
    let disposeBag = DisposeBag()
    let vm = ExtraSignUpViewModel.instance
    
    let star1Img = UIImageView(image: UIImage(named: "star")!)
    
    let incomeLb = UILabel().then {
        $0.text = "월소득"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let incomeTextField:UITextField = {
       let tf = UITextField()
        tf.placeholder = "EX)) 1,950,000"
        tf.borderStyle = .none
        tf.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
        let border = CALayer()
        border.frame = CGRect(x: 0, y: tf.frame.size.height - 1, width: tf.frame.width, height: 1)
        border.backgroundColor = CGColor.init(red: 151 / 255, green: 151 / 255, blue: 151 / 255, alpha: 1.0)
        tf.layer.addSublayer(border)
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let wonLb = UILabel().then {
        $0.text = "원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        $0.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
    }
    
    let star2Img = UIImageView(image: UIImage(named: "star")!)
    
    let employLb = UILabel().then {
        $0.text = "취업상태"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let subLb = UILabel().then {
        $0.text = "*중복 선택 가능"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 160, green: 160, blue: 160)
    }
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let cvData = Observable<[String]>.of(["전체", "미취업자", "재직자", "프리랜서", "일용근로자", "단기근로자", "예비창업자", "자영업자", "영농종사자"])
    let data = ["전체", "미취업자", "재직자", "프리랜서", "일용근로자", "단기근로자", "예비창업자", "자영업자", "영농종사자"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCV()
        setUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}

extension StepTwoView {
    func setUI() {
        addSubview(star1Img)
        star1Img.snp.makeConstraints {
            $0.top.equalToSuperview().offset(53)
            $0.leading.equalToSuperview().offset(25)
        }
        
        addSubview(incomeLb)
        incomeLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalTo(star1Img.snp.trailing).offset(4)
        }
        
        addSubview(wonLb)
        wonLb.snp.makeConstraints {
            $0.top.equalTo(incomeLb.snp.bottom).offset(22)
            $0.trailing.equalToSuperview().offset(-104)
        }
        
        addSubview(incomeTextField)
        incomeTextField.snp.makeConstraints {
            $0.top.equalTo(incomeLb.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalTo(wonLb.snp.leading).offset(-10)
        }
        
        addSubview(star2Img)
        star2Img.snp.makeConstraints {
            $0.top.equalTo(incomeTextField.snp.bottom).offset(53)
            $0.leading.equalToSuperview().offset(25)
        }
        
        addSubview(employLb)
        employLb.snp.makeConstraints {
            $0.top.equalTo(incomeTextField.snp.bottom).offset(49)
            $0.leading.equalTo(star2Img.snp.trailing).offset(4)
        }
        
        addSubview(subLb)
        subLb.snp.makeConstraints {
            $0.top.equalTo(employLb.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(25)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(subLb.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.bottom.equalToSuperview().offset(-210)
        }
        
    }
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        incomeTextField.rx.controlEvent([.editingDidEnd])
            .map { self.incomeTextField.text ?? "0" }
            .bind(to: self.vm.stepTwo.input.incomeObserver)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .map { index in
                let cell = self.collectionView.cellForItem(at: index) as? ExtraSignUpCell
                return cell?.title.text ?? ""
            }
            .bind(to: self.vm.stepTwo.input.employObserver)
            .disposed(by: disposeBag)
    }
    
    func bindOutput() {
        
        collectionView.rx.itemSelected
            .subscribe(onNext: { value in
                for i in 0..<self.data.count {
                    let cell = self.collectionView.cellForItem(at: [0, i]) as? ExtraSignUpCell
                    if self.vm.user.employmentState.contains(self.data[i]) {
                        cell?.title.textColor = .white
                        cell?.title.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
                        cell?.view.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
                    } else {
                        cell?.title.textColor = UIColor.rgb(red: 108, green: 108, blue: 108)
                        cell?.title.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
                        cell?.view.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
                    }
                }

            }).disposed(by: disposeBag)
        
    }
    
}

extension StepTwoView: UICollectionViewDelegateFlowLayout {
    
    func setCV() {
        incomeTextField.delegate = self
        collectionView.dataSource = nil
        collectionView.delegate = nil
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.register(ExtraSignUpCell.self, forCellWithReuseIdentifier: "cellID")
        cvData
            .bind(to: collectionView.rx.items(cellIdentifier: "cellID", cellType: ExtraSignUpCell.self)) {row, element, cell in
                cell.title.text = element
            }.disposed(by: disposeBag)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.frame.width - 94) / 3
        return CGSize(width: width, height: 42)
    }
}


class ExtraSignUpCell: UICollectionViewCell {
    
    let view = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
        $0.layer.cornerRadius = 23.5
    }
    
    let title = UILabel().then {
        $0.text = ""
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.textColor = UIColor.rgb(red: 108, green: 108, blue: 108)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(title)
        title.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StepTwoView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // replacementString : 방금 입력된 문자 하나, 붙여넣기 시에는 붙여넣어진 문자열 전체
        // return -> 텍스트가 바뀌어야 한다면 true, 아니라면 false
        // 이 메소드 내에서 textField.text는 현재 입력된 string이 붙기 전의 string
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // 1,000,000
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 0 // 허용하는 소숫점 자리수
        
        // formatter.groupingSeparator // .decimal -> ,
        
        if let removeAllSeprator = textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: ""){
            var beforeForemattedString = removeAllSeprator + string
            if formatter.number(from: string) != nil {
                if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                    textField.text = formattedString
                    return false
                }
            }else{ // 숫자가 아닐 때먽
                if string == "" { // 백스페이스일때
                    let lastIndex = beforeForemattedString.index(beforeForemattedString.endIndex, offsetBy: -1)
                    beforeForemattedString = String(beforeForemattedString[..<lastIndex])
                    if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                        textField.text = formattedString
                        return false
                    }
                }else{ // 문자일 때
                    return false
                }
            }

        }
        
        return true
    }
}
