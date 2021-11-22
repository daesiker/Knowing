//
//  HomeAllPostView.swift
//  Knowing
//
//  Created by Jun on 2021/10/27.
//

import Foundation
import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class HomeAllPostView: UIView {
    
    let disposeBag = DisposeBag()
    let cellID = "cellID"
    let headerID = "headerID"
    
    let allPostCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let allPostData = Observable<[String]>.of(["", "", "", "", "", ""])
    let headerData = Observable<String>.of("")
    
    let testData = ["", "", "", "", "", ""]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCV()
        addSubview(allPostCV)
        allPostCV.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-91)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCV() {
        allPostCV.delegate = self
        allPostCV.dataSource = self
        allPostCV.register(PostCell.self, forCellWithReuseIdentifier: cellID)
        allPostCV.register(HomeAllPostHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
//        allPostCV.rx.setDelegate(self).disposed(by: disposeBag)
//
//
//        allPostData
//            .bind(to: allPostCV.rx.items(cellIdentifier: cellID, cellType: PostCell.self)) { row, element, cell in
//                cell.backgroundColor = UIColor.rgb(red: 255, green: 246, blue: 232)
//            }.disposed(by: disposeBag)
        
    }
}

extension HomeAllPostView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PostCell
        cell.backgroundColor = UIColor.rgb(red: 255, green: 246, blue: 232)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! HomeAllPostHeader
        
        return header
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width - 40
        return CGSize(width: width, height: 133)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = frame.width
        return CGSize(width: width, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 20, bottom: 17, right: 20)
    }
    
}


class HomeAllPostHeader: UICollectionViewCell {
    
    let disposeBag = DisposeBag()
    
    let backImg = UIImageView(image: UIImage(named: "homeAllPost")!)
    
    let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        
        $0.backgroundColor = UIColor.rgb(red: 255, green: 228, blue: 182)
    }
    
    let studentBt = HomeAllPostBt("학생 지원")
    let employBt = HomeAllPostBt("취업 지원")
    let startUpBt = HomeAllPostBt("창업 지원")
    let residentBt = HomeAllPostBt("주거 · 금융 지원")
    let lifeBt = HomeAllPostBt("생활 · 복지 지원")
    let covidBt = HomeAllPostBt("코로나19 지원")
    
    let countLb = UILabel().then {
        $0.text = "총 68건"
        $0.textColor = UIColor.rgb(red: 171, green: 171, blue: 171)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
    }
    
    let sortTitle = UILabel().then {
        $0.text = "높은 금액순"
        $0.textColor = UIColor.rgb(red: 210, green: 132, blue: 81)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
    }
    
    let sortBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "filterImg")!, for: .normal)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setUI() {
        addSubview(backImg)
        backImg.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        let stackView = UIStackView(arrangedSubviews: [studentBt, employBt, startUpBt, residentBt, lifeBt, covidBt]).then {
            $0.axis = .horizontal
            $0.spacing = 16
            
        }
        
        scrollView.contentSize = CGSize(width: 500, height: 24)
        backImg.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-52)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(countLb)
        countLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(192)
            $0.leading.equalToSuperview().offset(20)
        }
        
        addSubview(sortBt)
        sortBt.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-13)
            $0.top.equalToSuperview().offset(184)
        }
        
        addSubview(sortTitle)
        sortTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(193)
            $0.trailing.equalTo(sortBt.snp.leading).offset(-6)
        }
    }
    
    
}
