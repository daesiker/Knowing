//
//  ExtraSignThreeView.swift
//  Knowing
//
//  Created by Jun on 2021/11/03.
//
import Foundation
import UIKit
import RxCocoa
import RxSwift

class StepThreeView: UIView{
    let disposeBag = DisposeBag()
    let vm = ExtraSignUpViewModel.instance
    
    let starImg = UIImageView(image: UIImage(named: "star")!)
    
    let recordsLb = UILabel().then {
        $0.text = "학적사항"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let cvData = Observable<[String]>.of(["전체", "고졸미만", "고교졸업", "대학재학", "대학졸업", "석박사"])
    let data = ["전체", "고졸미만", "고교졸업", "대학재학", "대학졸업", "석박사"]
    
    let schollLb = UILabel().then {
        $0.text = "학교"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let schoolBt = CustomPicker("학교 선택")
    
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

extension StepThreeView {
    
    func setUI() {
        addSubview(starImg)
        starImg.snp.makeConstraints {
            $0.top.equalToSuperview().offset(53)
            $0.leading.equalToSuperview().offset(25)
        }
        
        addSubview(recordsLb)
        recordsLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalTo(starImg.snp.trailing).offset(4)
        }
        
        addSubview(schollLb)
        schollLb.snp.makeConstraints {
            $0.top.equalTo(recordsLb.snp.bottom).offset(176)
            $0.leading.equalToSuperview().offset(25)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.top.equalTo(recordsLb.snp.bottom).offset(24)
            $0.bottom.equalTo(schollLb.snp.top).offset(-50)
        }
        
        addSubview(schoolBt)
        schoolBt.snp.makeConstraints {
            $0.top.equalTo(schollLb.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
    }
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        collectionView.rx.itemSelected
            .map { index in
                let cell = self.collectionView.cellForItem(at: index) as? ExtraSignUpCell
                return cell?.title.text ?? ""
            }
            .bind(to: self.vm.stepThree.input.recordsObserver)
            .disposed(by: disposeBag)
        
        schoolBt.rx.tap
            .bind(to: self.vm.stepThree.input.schoolViewObserver)
            .disposed(by: disposeBag)
    }
    
    func bindOutput() {
        collectionView.rx.itemSelected
            .subscribe(onNext: { value in
                for i in 0..<self.data.count {
                    let cell = self.collectionView.cellForItem(at: [0, i]) as? ExtraSignUpCell
                    if self.vm.user.schollRecords.contains(self.data[i]) {
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

extension StepThreeView: UICollectionViewDelegateFlowLayout {
    
    func setCV() {
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
