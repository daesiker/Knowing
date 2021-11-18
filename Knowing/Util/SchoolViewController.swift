//
//  SchoolViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/18.
//

import UIKit
import RxCocoa
import RxSwift
import PanModal

class SchoolViewController: UIViewController {
    let cellId = "cellId"
    let disposeBag = DisposeBag()
    let vm = ExtraSignUpViewModel.instance
    
    let backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 40.0
    }
    let titleLabel = UILabel().then {
        $0.text = "학교 선택"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "GodoM", size: 20)
    }
    
    let cancelBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "largeCancel")!, for: .normal)
    }
    
    let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setUI()
        bind()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}


extension SchoolViewController {
    
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
            $0.top.equalTo(separator.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func bind() {
        cancelBt.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .map { self.searchBar.text ?? "" }
            .distinctUntilChanged()
            .bind(to: vm.schoolSelect.input.searchObserver)
            .disposed(by: disposeBag)
        
        vm.schoolSelect.output.schoolValue.drive(onNext: { _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
    }
    
    func setCollectionView() {
        collectionView.delegate = nil
        collectionView.dataSource = nil
        collectionView.register(AddressCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        
        vm.schoolSelect.output.target
            .drive(collectionView.rx.items(cellIdentifier: cellId, cellType: AddressCell.self)) {row, element, cell in
                cell.title.text = element
            }.disposed(by: disposeBag)
        
        
        collectionView.rx
            .itemSelected
            .map { index in
                let cell = self.collectionView.cellForItem(at: index) as? AddressCell
                return cell?.title.text ?? ""
            }
            .bind(to: vm.schoolSelect.input.schoolValueObserver)
            .disposed(by: disposeBag)
        
        
    }
    
}

extension SchoolViewController: PanModalPresentable {
    
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

extension SchoolViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        let width = (view.frame.width - 100) 
        return CGSize(width: width, height: 41)
    }
    
}
