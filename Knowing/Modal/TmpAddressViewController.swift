//
//  TmpAddressViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/16.
//

import UIKit
import PanModal
import RxSwift
import RxCocoa

class TmpAddressViewController: UIViewController {

    let disposeBag = DisposeBag()
    let vm = ExtraSignUpViewModel.instance
    
    var modiVm: ExtraModifyViewModel?
    
    
    let backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 40.0
    }
    
    let titleLabel = UILabel().then {
        $0.text = "시/도 선택"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "GodoM", size: 20)
    }
    
    let cancelBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "largeCancel")!, for: .normal)
    }
    
    let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.searchTextField.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
        $0.layer.cornerRadius = 30
        $0.placeholder = "검색어를 입력해주세요."
    }
    
    let separator = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 221, green: 221, blue: 221)
    }
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let midSeparator = UIView().then {
        $0.layer.cornerRadius = 3.0
        $0.backgroundColor = UIColor.rgb(red: 216, green: 216, blue: 216)
    }
    
    let subTitle = UILabel().then {
        $0.text = "다른 지역은 다음에 업데이트 예정이에요!"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.textColor = UIColor.rgb(red: 105, green: 105, blue: 105)
    }
    
    let subTitle2 = UILabel().then {
        $0.text = "조금만 더 기다려 주세요."
        $0.textColor = UIColor.rgb(red: 147, green: 147, blue: 147)
        $0.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
    }
    
    let nextTimeImg = UIImageView(image: UIImage(named: "nextTimeImg")!)
    
    let cellId = "cellId"
    var allItem = ["서울특별시", "인천광역시", "경기도", "세종특별자치시"]
    var selectedItem = Observable<[String]>.of(["서울특별시", "인천광역시", "경기도", "세종특별자치시"])
    var isCity:Bool = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setUI()
        bind()
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setUI() {
        view.backgroundColor = .clear
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.centerX.equalToSuperview()
        }
        
        backgroundView.addSubview(cancelBt)
        cancelBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().offset(-31)
        }
        
        backgroundView.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(26)
            $0.trailing.equalToSuperview().offset(-26)
            $0.height.equalTo(47)
        }
        
        backgroundView.addSubview(separator)
        separator.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        backgroundView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(15)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.bottom.equalTo(backgroundView.snp.top).offset(249)
            
        }
        
        backgroundView.addSubview(midSeparator)
        midSeparator.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(6)
        }
        
        backgroundView.addSubview(subTitle)
        subTitle.snp.makeConstraints {
            $0.top.equalTo(midSeparator.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
        }
        
        backgroundView.addSubview(subTitle2)
        subTitle2.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        backgroundView.addSubview(nextTimeImg)
        nextTimeImg.snp.makeConstraints {
            $0.top.equalTo(subTitle2.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
        }
        
        
        
    }
    
    func bind() {
        cancelBt.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        vm.stepOne.output.cityValue.drive(onNext: { _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        vm.stepOne.output.guValue.drive(onNext: { _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        modiVm?.output.cityValue.asDriver(onErrorJustReturn: "")
            .drive(onNext: { value in
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        selectedItem.bind(to: vm.addressSelect.input.cellObserver).disposed(by: disposeBag)
        
        searchBar.rx.text
            .orEmpty
            .throttle(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: vm.addressSelect.input.searchObserver)
            .disposed(by: disposeBag)
        
    }
    
    func setCollectionView() {
        collectionView.delegate = nil
        collectionView.dataSource = nil
        collectionView.register(AddressCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        
        
        vm.addressSelect.output.target
            .drive(collectionView.rx.items(cellIdentifier: cellId, cellType: AddressCell.self)) {row, element, cell in
                cell.title.text = element
            }.disposed(by: disposeBag)
        
        collectionView.rx
            .itemSelected
            .map { index in
                let cell = self.collectionView.cellForItem(at: index) as? AddressCell
                return cell?.title.text ?? ""
            }
            .bind(to: self.modiVm == nil ? vm.stepOne.input.cityValueObserver : modiVm!.input.cityValue)
            .disposed(by: disposeBag)
        
        
    }
    
    
}

extension TmpAddressViewController: PanModalPresentable {
    
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

extension TmpAddressViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
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
