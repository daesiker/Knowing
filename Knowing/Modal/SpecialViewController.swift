//
//  SpecialViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/11.
//

import UIKit
import RxSwift
import RxRelay
import PanModal

class SpecialViewController: UIViewController {

    let disposeBag = DisposeBag()
    let vm = ExtraSignUpViewModel.instance
    var modiVm:ExtraModifyViewModel?
    
    let backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 40.0
    }
    
    let titleLabel = UILabel().then {
        $0.text = "특별사항 선택"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "GodoM", size: 20)
    }
    
    let cancelBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "largeCancel")!, for: .normal)
    }
    
    let separator = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 221, green: 221, blue: 221)
    }
    
    let checkBoxBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
    }
    
    let checkBoxLb = UILabel().then {
        $0.text = "선택사항 없음"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
    }
    
    let separator2 = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
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
    
    let cvData = Observable<[String]>.of(["중소기업", "저소득층", "장애인", "농업인", "군인", "지역인재"])
    let cvDommy = ["중소기업", "저소득층", "장애인", "농업인", "군인", "지역인재"]
    let cellId = "cellId"
    
    let nextBt = UIButton(type: .custom).then {
        $0.setTitle("적용하기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = UIColor.rgb(red: 210, green: 210, blue: 210)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 133, bottom: 13, right: 134)
        $0.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCV()
        setUI()
        bind()
    }
    
    
}

extension SpecialViewController {
    func setUI() {
        view.backgroundColor = .clear
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.centerX.equalToSuperview()
        }
        
        backgroundView.addSubview(cancelBt)
        cancelBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().offset(-31)
        }
        
        backgroundView.addSubview(separator)
        separator.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        backgroundView.addSubview(checkBoxBt)
        checkBoxBt.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalTo(separator.snp.bottom).offset(5)
            $0.width.equalTo(47)
            $0.height.equalTo(47)
        }
        
        backgroundView.addSubview(checkBoxLb)
        checkBoxLb.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(21)
            $0.leading.equalTo(checkBoxBt.snp.trailing).offset(2)
        }
        
        backgroundView.addSubview(separator2)
        separator2.snp.makeConstraints {
            $0.top.equalTo(checkBoxLb.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(27)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(1)
        }
        
        backgroundView.addSubview(subLb)
        subLb.snp.makeConstraints {
            $0.top.equalTo(separator2.snp.bottom).offset(23)
            $0.leading.equalToSuperview().offset(28)
        }
        
        backgroundView.addSubview(nextBt)
        nextBt.snp.makeConstraints {
            $0.top.equalTo(subLb.snp.bottom).offset(247)
            $0.leading.equalToSuperview().offset(26)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        backgroundView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(subLb.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(nextBt.snp.top)
            
        }
        
        
        
    }
    
    func bind() {
        cancelBt.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        
        checkBoxBt.rx.tap
            .map { "none" }
            .bind(to: modiVm != nil ? modiVm!.input.specialValue : vm.stepOne.input.specialNoneValueObserver)
            .disposed(by: disposeBag)
        
        vm.stepOne.output.spcialNoneValue.drive(onNext: {value in
            if value {
                self.checkBoxBt.setImage(UIImage(named: "checkbox_selected")!, for: .normal)
            } else {
                self.checkBoxBt.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
            }
        }).disposed(by: disposeBag)
        
        
        vm.stepOne.output.specialBtValid.drive(onNext: { value in
            if value {
                self.nextBt.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
                self.nextBt.isEnabled = true
            } else {
                self.nextBt.backgroundColor = UIColor.rgb(red: 210, green: 210, blue: 210)
                self.nextBt.isEnabled = false
            }
        }).disposed(by: disposeBag)
        
        nextBt.rx.tap
            .bind(to: modiVm != nil ? modiVm!.input.specialViewDismiss : vm.stepOne.input.specialButtonObserver)
            .disposed(by: disposeBag)
        
        
        vm.stepOne.output.dismissSpecialView.drive(onNext: { _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        modiVm?.output.specialBtEnable.asDriver(onErrorJustReturn: false)
            .drive(onNext: {value in
                if value {
                    self.nextBt.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
                    self.nextBt.isEnabled = true
                } else {
                    self.nextBt.backgroundColor = UIColor.rgb(red: 210, green: 210, blue: 210)
                    self.nextBt.isEnabled = false
                }
            }).disposed(by: disposeBag)
        
        modiVm?.output.specialViewDismiss.asDriver(onErrorJustReturn: ())
            .drive(onNext: {
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        modiVm?.output.specialValue.asDriver(onErrorJustReturn: [])
            .drive(onNext: { value in
                if value == ["none"] {
                    self.checkBoxBt.setImage(UIImage(named: "checkbox_selected")!, for: .normal)
                } else {
                    self.checkBoxBt.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
                }
                self.collectionView.reloadData()
            }).disposed(by: disposeBag)
        
    }
    
    func setCV() {
        
        collectionView.delegate = nil
        collectionView.dataSource = nil
        collectionView.register(SpecialCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        cvData
            .bind(to: collectionView.rx.items(cellIdentifier: cellId, cellType: SpecialCell.self)) {row, element, cell in
                if self.modiVm != nil {
                    if self.modiVm!.user.specialStatus.contains(element) {
                        cell.view.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
                        cell.title.textColor = .white
                    }
                }
                cell.configure(name: element)
            }.disposed(by: disposeBag)
        
        collectionView.rx
            .itemSelected
            .map { index in
                let cell = self.collectionView.cellForItem(at: index) as? SpecialCell
                if cell?.title.textColor == .white {
                    cell?.view.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
                    cell?.title.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
                    cell?.title.textColor = UIColor.rgb(red: 108, green: 108, blue: 108)
                } else {
                    cell?.view.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
                    cell?.title.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
                    cell?.title.textColor = .white
                }
                return cell?.title.text ?? ""
            }
            .bind(to: modiVm != nil ? modiVm!.input.specialValue : self.vm.stepOne.input.specialValueObserver)
            .disposed(by: disposeBag)
        
//        collectionView.rx
//            .itemSelected
//            .subscribe(onNext: { value in
//                for i in 0..<self.cvDommy.count {
//                    let cell = self.collectionView.cellForItem(at: [0, i]) as! SpecialCell
//                    
//                    if self.modiVm != nil {
//                        if self.modiVm!.user.specialStatus.contains(cell.title.text ?? "") {
//                            cell.view.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
//                            cell.title.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
//                            cell.title.textColor = .white
//                        } else {
//                            cell.view.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
//                            cell.title.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
//                            cell.title.textColor = UIColor.rgb(red: 108, green: 108, blue: 108)
//                        }
//                    } else {
//                        if self.vm.user.specialStatus.contains(cell.title.text ?? "") {
//                            cell.title.textColor = .white
//                            cell.title.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
//                            cell.view.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
//                        } else {
//                            cell.title.textColor = UIColor.rgb(red: 108, green: 108, blue: 108)
//                            cell.title.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
//                            cell.view.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
//                        }
//                    }
//                }
//                self.collectionView.reloadData()
//            }).disposed(by: disposeBag)
        
    }
}

extension SpecialViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(self.view.frame.height * 0.64)
        }
    
    //Modal background color
    var panModalBackgroundColor: UIColor {
        return UIColor.black.withAlphaComponent(0.2)
    }
    
    //Whether to round the top corners of the modal
    var shouldRoundTopCorners: Bool {
        return true
    }
    
}

extension SpecialViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 23
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 73) / 2
        return CGSize(width: width, height: 41)
    }
    
}

class SpecialCell: UICollectionViewCell {
    
    let view = UIView().then {
        $0.layer.cornerRadius = 23.5
        $0.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
    }
    
    let title = UILabel().then {
        $0.text = ""
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
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
    
    func configure(name: String) {
        
        title.text = name
    }
    
}
