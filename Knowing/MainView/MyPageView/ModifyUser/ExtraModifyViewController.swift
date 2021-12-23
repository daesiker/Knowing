//
//  ExtraModifyViewController.swift
//  Knowing
//
//  Created by Jun on 2021/12/14.
//

import UIKit
import RxSwift
import RxCocoa
import PanModal

class ExtraModifyViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let vm:ExtraModifyViewModel
    
    
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let titleLb = UILabel().then {
        $0.text = "추가 정보 수정하기"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "GodoM", size: 18)
    }
    
    let separator1 = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
    }
    
    let separator2 = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245)
    }
    
    let modifyBt = UIButton(type: .custom).then {
        $0.setTitle("수정하기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 135, bottom: 16, right: 134)
    }
    
    let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.automaticallyAdjustsScrollIndicatorInsets = true
        $0.clipsToBounds = true
        $0.layoutIfNeeded()
        $0.backgroundColor = .white
    }
    
    let subTitle1 = UILabel().then {
        $0.text = "카테고리 중 "
        $0.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.textColor = UIColor.rgb(red: 147, green: 147, blue: 147)
    }
    
    let subTitle2 = UIImageView(image: UIImage(named: "star")!).then {
        $0.contentMode = .scaleAspectFit
    }
    
    let subTitle3 = UILabel().then {
        $0.text = "은 필수 기재 사항이에요."
        $0.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.textColor = UIColor.rgb(red: 147, green: 147, blue: 147)
    }
    
    let starImg = UIImageView(image: UIImage(named: "star")!)
    
    let residenceLb = UILabel().then {
        $0.text = "거주지"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let cityBt = CustomPicker("시/도 선택")
    let guBt = CustomPicker("시/군/구 선택")
    
    let starImg2 = UIImageView(image: UIImage(named: "star")!)
    
    let specialLb = UILabel().then {
        $0.text = "특별사항"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let specialBt = CustomPicker("특별사항 선택")
    
    let starImg3 = UIImageView(image: UIImage(named: "star")!)
    
    let incomeLb = UILabel().then {
        $0.text = "월소득"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let incomeTextField:UITextField = {
       let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "EX)) 1,950,000", attributes: [NSAttributedString.Key.foregroundColor : UIColor.rgb(red: 194, green: 194, blue: 194)])
        tf.borderStyle = .none
        tf.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
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
    
    let starImg4 = UIImageView(image: UIImage(named: "star")!)
    
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
    
    let employCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let employData = Observable<[String]>.of(["전체", "미취업자", "재직자", "프리랜서", "일용근로자", "단기근로자", "예비창업자", "자영업자", "영농종사자"])
    let employDummy = ["전체", "미취업자", "재직자", "프리랜서", "일용근로자", "단기근로자", "예비창업자", "자영업자", "영농종사자"]
    
    let starImg5 = UIImageView(image: UIImage(named: "star")!)
    
    let recordsLb = UILabel().then {
        $0.text = "학적사항"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let recordsCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let recordsData = Observable<[String]>.of(["전체", "고졸미만", "고교졸업", "대학재학", "대학졸업", "석박사"])
    let recordsDummy = ["전체", "고졸미만", "고교졸업", "대학재학", "대학졸업", "석박사"]
    
    let schollLb = UILabel().then {
        $0.text = "학교"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let schoolBt = CustomPicker("학교 선택")
    
    let majorLabel = UILabel().then {
        $0.text = "전공 계열"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let majorCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let majorData = Observable<[String]>.of(["인문", "사회", "법", "경영", "교육", "공학", "자연", "예체능", "의약", "기타"])
    let dataCount = 10
    
    let detailLabel = UILabel().then {
        $0.text = "학과"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let detailTextField:UITextField = {
       let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "ex)) 경영", attributes: [NSAttributedString.Key.foregroundColor : UIColor.rgb(red: 194, green: 194, blue: 194)])
        tf.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        tf.borderStyle = .none
        tf.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
        let border = CALayer()
        border.frame = CGRect(x: 0, y: tf.frame.size.height - 1, width: tf.frame.width, height: 1)
        border.backgroundColor = CGColor.init(red: 151 / 255, green: 151 / 255, blue: 151 / 255, alpha: 1.0)
        tf.layer.addSublayer(border)
        
        return tf
    }()
    
    let subLabel = UILabel().then {
        $0.text = "학과"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        $0.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
    }
    
    
    let semeLabel = UILabel().then {
        $0.text = "현재 학기"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let semeTextField:UITextField = {
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
        tf.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
        tf.bounds.inset(by: UIEdgeInsets(top: 4, left: 0, bottom: 11, right: 31))
        tf.rightView = UIImageView(image: UIImage(named: "triangle")!)
        tf.rightViewMode = .always
        return tf
    }()
    let schoolData:[[String]] = [["1", "2", "3", "4"],["학년"], ["1", "2"], ["학기"]]
    
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
    
    let scoreCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let scoreDomy:[String] = ["~2.99", "3.0~3.44", "3.5~3.99", "해당 없음"]
    let scoreData = Observable<[String]>.of(["~2.99", "3.0~3.44", "3.5~3.99", "해당 없음"])
    
    init(vm: ExtraModifyViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue()
        setUI()
        setCV()
        bind()
    }
    
    func setValue() {
        cityBt.label.text = vm.user.address
        cityBt.label.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
        
        guBt.label.text = vm.user.addressDetail
        guBt.label.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
        
        if vm.user.specialStatus == ["none"] {
            specialBt.label.text = "선택사항 없음"
            specialBt.label.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
        } else {
            specialBt.label.text = "선택사항 \(vm.user.specialStatus.count)개"
            specialBt.label.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
        }
        
        if vm.user.school != "" {
            schoolBt.label.text = vm.user.school
            schoolBt.label.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
        }
        
        if vm.user.mainMajor != "" {
            detailTextField.text = vm.user.subMajor
        }
        
        if vm.user.semester != "" {
            semeTextField.text = vm.user.semester
        }
        
    }
    
    func setUI() {
        self.lightMode()
        view.backgroundColor = .white
        
        safeArea.addSubview(backBt)
        backBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(20)
        }
        
        safeArea.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(separator1)
        separator1.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        safeArea.addSubview(separator2)
        separator2.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-63)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        safeArea.addSubview(modifyBt)
        modifyBt.snp.makeConstraints {
            $0.top.equalTo(separator2.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        safeArea.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(separator1.snp.bottom)
            $0.bottom.equalTo(separator2.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        let subTitle = UIStackView(arrangedSubviews: [subTitle1, subTitle2, subTitle3]).then {
            $0.axis = .horizontal
            $0.spacing = 1
            $0.distribution = .fillProportionally
        }
        
        scrollView.addSubview(subTitle)
        subTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(33)
            $0.leading.equalToSuperview().offset(25)
        }
        
        scrollView.addSubview(starImg)
        starImg.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(52)
            $0.leading.equalToSuperview().offset(26)
        }
        
        scrollView.addSubview(residenceLb)
        residenceLb.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(50)
            $0.leading.equalTo(starImg.snp.trailing).offset(4)
        }
        
        scrollView.addSubview(cityBt)
        cityBt.snp.makeConstraints {
            $0.top.equalTo(residenceLb.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(25)
            $0.width.equalTo(113)
        }
        
        scrollView.addSubview(guBt)
        guBt.snp.makeConstraints {
            $0.top.equalTo(residenceLb.snp.bottom).offset(20)
            $0.leading.equalTo(cityBt.snp.trailing).offset(25.5)
            $0.width.equalTo(113)
        }
        
        scrollView.addSubview(starImg2)
        starImg2.snp.makeConstraints {
            $0.top.equalTo(cityBt.snp.bottom).offset(53)
            $0.leading.equalToSuperview().offset(26)
        }
        
        scrollView.addSubview(specialLb)
        specialLb.snp.makeConstraints {
            $0.top.equalTo(cityBt.snp.bottom).offset(50)
            $0.leading.equalTo(starImg2.snp.trailing).offset(4)
        }
        
        scrollView.addSubview(specialBt)
        specialBt.snp.makeConstraints {
            $0.top.equalTo(specialLb.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(25)
            $0.width.equalTo(113)
        }
        
        scrollView.addSubview(starImg3)
        starImg3.snp.makeConstraints {
            $0.top.equalTo(specialBt.snp.bottom).offset(53)
            $0.leading.equalToSuperview().offset(25)
        }
        
        scrollView.addSubview(incomeLb)
        incomeLb.snp.makeConstraints {
            $0.top.equalTo(specialBt.snp.bottom).offset(50)
            $0.leading.equalTo(starImg3.snp.trailing).offset(4)
        }
        
        scrollView.addSubview(wonLb)
        wonLb.snp.makeConstraints {
            $0.top.equalTo(incomeLb.snp.bottom).offset(21)
            $0.trailing.equalToSuperview().offset(-104)
        }
        
        scrollView.addSubview(incomeTextField)
        incomeTextField.snp.makeConstraints {
            $0.top.equalTo(incomeLb.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalTo(wonLb.snp.leading).offset(-10)
        }
        
        scrollView.addSubview(starImg4)
        starImg4.snp.makeConstraints {
            $0.top.equalTo(incomeTextField.snp.bottom).offset(53)
            $0.leading.equalToSuperview().offset(25)
        }
        
        scrollView.addSubview(employLb)
        employLb.snp.makeConstraints {
            $0.top.equalTo(incomeTextField.snp.bottom).offset(49)
            $0.leading.equalTo(starImg4.snp.trailing).offset(4)
        }
        
        scrollView.addSubview(subLb)
        subLb.snp.makeConstraints {
            $0.top.equalTo(employLb.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(25)
        }
        
        scrollView.addSubview(employCV)
        employCV.snp.makeConstraints {
            $0.top.equalTo(subLb.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(25)
            $0.width.equalTo(self.view.frame.width - 50)
            $0.height.equalTo(160)
        }
        
        scrollView.addSubview(starImg5)
        starImg5.snp.makeConstraints {
            $0.top.equalTo(employCV.snp.bottom).offset(53)
            $0.leading.equalToSuperview().offset(25)
        }

        scrollView.addSubview(recordsLb)
        recordsLb.snp.makeConstraints {
            $0.top.equalTo(employCV.snp.bottom).offset(50)
            $0.leading.equalTo(starImg5.snp.trailing).offset(4)
        }

        scrollView.addSubview(recordsCV)
        recordsCV.snp.makeConstraints {
            $0.top.equalTo(recordsLb.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(25)
            $0.width.equalTo(self.view.frame.width-50)
            $0.height.equalTo(102)
        }

        scrollView.addSubview(schollLb)
        schollLb.snp.makeConstraints {
            $0.top.equalTo(recordsCV.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(25)
        }

        scrollView.addSubview(schoolBt)
        schoolBt.snp.makeConstraints {
            $0.top.equalTo(schollLb.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(25)
            $0.width.equalTo(self.view.frame.width - 50)
        }
        
        scrollView.addSubview(majorLabel)
        majorLabel.snp.makeConstraints {
            $0.top.equalTo(schoolBt.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(25)
        }
        
        scrollView.addSubview(majorCV)
        majorCV.snp.makeConstraints {
            $0.top.equalTo(majorLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(25)
            $0.width.equalTo(self.view.frame.width-50)
            $0.height.equalTo(219)
        }
        
        scrollView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(majorCV.snp.bottom).offset(50)
        }
        
        scrollView.addSubview(detailTextField)
        detailTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(detailLabel.snp.bottom).offset(24)
            $0.width.equalTo(208)
        }
        
        scrollView.addSubview(subLabel)
        subLabel.snp.makeConstraints {
            $0.leading.equalTo(detailTextField.snp.trailing).offset(10)
            $0.top.equalTo(detailLabel.snp.bottom).offset(26)
        }
        
        scrollView.addSubview(semeLabel)
        semeLabel.snp.makeConstraints {
            $0.top.equalTo(detailTextField.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(25)
        }
        
        scrollView.addSubview(semeTextField)
        semeTextField.snp.makeConstraints {
            $0.top.equalTo(semeLabel.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(26)
            $0.width.equalTo(146)
        }
        
        scrollView.addSubview(checkBox)
        checkBox.snp.makeConstraints {
            $0.top.equalTo(semeTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(17)
        }
        
        scrollView.addSubview(deferredLabel)
        deferredLabel.snp.makeConstraints {
            $0.top.equalTo(semeTextField.snp.bottom).offset(22)
            $0.leading.equalTo(checkBox.snp.trailing).offset(3)
        }
        
        scrollView.addSubview(lastSemeLabel)
        lastSemeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(deferredLabel.snp.bottom).offset(50)
        }
        
        scrollView.addSubview(scoreCV)
        scoreCV.snp.makeConstraints {
            $0.top.equalTo(lastSemeLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(25)
            $0.width.equalTo(self.view.frame.width-50)
            $0.height.equalTo(101)
        }
        
        scrollView.layoutIfNeeded()
        
        scrollView.updateContentSize()
        
    }
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        
        backBt.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        cityBt.rx.tap
            .subscribe(onNext: {
                let vc = TmpAddressViewController()
                vc.modiVm = self.vm
                self.presentPanModal(vc)
            }).disposed(by: disposeBag)
        
        guBt.rx.tap
            .subscribe(onNext: {
                let value = self.vm.user.address
                if value != "시/도 선택" {
                    let vc = AddressViewController()
                    vc.allItem = address[value] ?? []
                    vc.selectedItem = Observable<[String]>.of(address[value] ?? [])
                    vc.modiVm = self.vm
                    vc.isCity = false
                    self.presentPanModal(vc)
                }
            }).disposed(by: disposeBag)
        
        specialBt.rx.tap
            .subscribe(onNext: {
                let vc = SpecialViewController()
                vc.modiVm = self.vm
                self.presentPanModal(vc)
            }).disposed(by: disposeBag)
        
        incomeTextField.delegate = self
        incomeTextField.rx.controlEvent([.editingDidEnd])
            .map { self.incomeTextField.text ?? "0" }
            .bind(to: vm.input.incomeValue)
            .disposed(by: disposeBag)
        
        schoolBt.rx.tap.subscribe(onNext: {
            let vc = SchoolViewController()
            vc.modiVm = self.vm
            self.presentPanModal(vc)
        }).disposed(by: disposeBag)
        
        detailTextField.rx.controlEvent([.editingDidEnd])
            .map { self.detailTextField.text ?? "" }
            .bind(to: vm.input.subMajorValue)
            .disposed(by: disposeBag)
        
        detailPicker.delegate = self
        detailPicker.dataSource = self
        semeTextField.inputView = detailPicker
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.tapCancel))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        semeTextField.inputAccessoryView = toolBar
        semeTextField.rx.controlEvent([.editingDidEnd])
            .map { self.semeTextField.text ?? "" }
            .bind(to: vm.input.semesterValue)
            .disposed(by: disposeBag)
        
        modifyBt.rx.tap
            .bind(to: vm.input.modifyBt)
            .disposed(by: disposeBag)
        
    }
    
    @objc func tapCancel() {
        semeTextField.resignFirstResponder()
    }
    
    func bindOutput() {
        
        vm.output.cityValue.asDriver(onErrorJustReturn: "")
            .drive(onNext: { value in
                self.cityBt.label.text = value
                self.guBt.label.text = "시/군/구 선택"
                self.guBt.label.textColor = UIColor.rgb(red: 194, green: 194, blue: 194)
            }).disposed(by: disposeBag)
        
        vm.output.guValue.asDriver(onErrorJustReturn: "")
            .drive(onNext: {value in
                self.guBt.label.text = value
                self.guBt.label.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
            }).disposed(by: disposeBag)
        
        vm.output.specialValue.asDriver(onErrorJustReturn: [])
            .drive(onNext: { value in
                if value == ["none"] {
                    self.specialBt.label.text = "선택사항 없음"
                    self.specialBt.label.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
                } else {
                    self.specialBt.label.text = "선택사항 \(value.count)개"
                    self.specialBt.label.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
                }
            }).disposed(by: disposeBag)
        
        vm.output.schoolValue.asDriver(onErrorJustReturn: "")
            .drive(onNext: { value in
                self.schoolBt.label.text = value
            }).disposed(by: disposeBag)
        
        vm.output.successValue.asDriver(onErrorJustReturn: ())
            .drive(onNext: {
                let vc = LoadingViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
        
        vm.output.errorValue.asSignal()
            .emit(onNext: { _ in
                let vc = UIAlertController(title: "에러", message: "필수 데이터를 입력해주세요.", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel)
                vc.addAction(action)
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
        
    }
    
    func setCV() {
        employCV.delegate = nil
        employCV.dataSource = nil
        employCV.rx.setDelegate(self).disposed(by: disposeBag)
        employCV.register(ExtraSignUpCell.self, forCellWithReuseIdentifier: "employCell")
        employData
            .bind(to: employCV.rx.items(cellIdentifier: "employCell", cellType: ExtraSignUpCell.self)) {row, element, cell in
                if self.vm.user.employmentState.contains(element) {
                    cell.title.textColor = .white
                    cell.title.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
                    cell.view.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
                }
                cell.title.text = element
            }.disposed(by: disposeBag)
        employCV.rx.itemSelected
            .map { index in
                let cell = self.employCV.cellForItem(at: index) as? ExtraSignUpCell
                return cell?.title.text ?? ""
            }
            .bind(to: self.vm.input.employValue)
            .disposed(by: disposeBag)
        employCV.rx.itemSelected
            .subscribe(onNext: { value in
                for i in 0..<self.employDummy.count {
                    let cell = self.employCV.cellForItem(at: [0, i]) as? ExtraSignUpCell
                    if self.vm.user.employmentState.contains(self.employDummy[i]) {
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
        
        recordsCV.delegate = nil
        recordsCV.dataSource = nil
        recordsCV.rx.setDelegate(self).disposed(by: disposeBag)
        recordsCV.register(ExtraSignUpCell.self, forCellWithReuseIdentifier: "recordsCell")
        recordsData
            .bind(to: recordsCV.rx.items(cellIdentifier: "recordsCell", cellType: ExtraSignUpCell.self)) { row, element, cell in
                if self.vm.user.schoolRecords == element {
                    cell.title.textColor = .white
                    cell.title.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
                    cell.view.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
                }
                cell.title.text = element
            }.disposed(by: disposeBag)
        recordsCV.rx.itemSelected
            .map { index in
                let cell = self.recordsCV.cellForItem(at: index) as? ExtraSignUpCell
                return cell?.title.text ?? ""
            }
            .bind(to: self.vm.input.recordsValue)
            .disposed(by: disposeBag)
        recordsCV.rx.itemSelected
            .subscribe(onNext: { value in
                for i in 0..<self.recordsDummy.count {
                    let cell = self.recordsCV.cellForItem(at: [0, i]) as? ExtraSignUpCell
                    if self.vm.user.schoolRecords == self.recordsDummy[i] {
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
        
        
        
        majorCV.delegate = nil
        majorCV.dataSource = nil
        majorCV.rx.setDelegate(self).disposed(by: disposeBag)
        majorCV.register(ExtraSignUpCell.self, forCellWithReuseIdentifier: "majorCell")
        majorData
            .bind(to: majorCV.rx.items(cellIdentifier: "majorCell", cellType: ExtraSignUpCell.self)) { row, element, cell in
                if self.vm.user.mainMajor == element {
                    cell.title.textColor = .white
                    cell.title.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
                    cell.view.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
                }
                cell.title.text = element
            }.disposed(by: disposeBag)
        majorCV.rx.itemSelected
            .subscribe(onNext: { value in
                for i in 0..<10 {
                    let cell = self.majorCV.cellForItem(at: [0, i]) as? ExtraSignUpCell
                    if self.vm.user.mainMajor == cell?.title.text {
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
        majorCV.rx.itemSelected
            .map { index in
                let cell = self.majorCV.cellForItem(at: index) as? ExtraSignUpCell
                return cell?.title.text ?? ""
            }
            .bind(to: self.vm.input.mainMajorValue)
            .disposed(by: disposeBag)
        
        
        scoreCV.delegate = nil
        scoreCV.dataSource = nil
        scoreCV.rx.setDelegate(self).disposed(by: disposeBag)
        scoreCV.register(ExtraSignUpCell.self, forCellWithReuseIdentifier: "scoreCell")
        scoreData
            .bind(to: scoreCV.rx.items(cellIdentifier: "scoreCell", cellType: ExtraSignUpCell.self)) { row, element, cell in
                if self.vm.user.lastSemesterScore == element {
                    cell.title.textColor = .white
                    cell.title.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
                    cell.view.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
                }
                cell.title.text = element
            }.disposed(by: disposeBag)
        scoreCV.rx.itemSelected
            .subscribe(onNext: { value in
                for i in 0..<self.scoreDomy.count {
                    let cell = self.scoreCV.cellForItem(at: [0, i]) as? ExtraSignUpCell
                    if self.vm.user.lastSemesterScore == cell?.title.text {
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
        scoreCV.rx.itemSelected
            .map { index in
                let cell = self.scoreCV.cellForItem(at: index) as? ExtraSignUpCell
                return cell?.title.text ?? ""
            }
            .bind(to: self.vm.input.scoreValue)
            .disposed(by: disposeBag)
        
        
    }
    
    
    

}

extension ExtraModifyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        var tmp1 = "2학년 "
        var tmp2 = "2학기"
        if component == 0 {
            tmp1 = "\(schoolData[component][row])학년  "
        }
        if component == 2 {
            tmp2 = "\(schoolData[component][row])학기"
        }
        
        semeTextField.text = tmp1 + tmp2
    }
    
}

extension ExtraModifyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 84) / 3
        return CGSize(width: width, height: 42)
    }
}

extension ExtraModifyViewController: UITextFieldDelegate {
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
