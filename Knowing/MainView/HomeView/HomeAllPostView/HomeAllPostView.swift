//
//  HomeAllPostView.swift
//  Knowing
//
//  Created by Jun on 2021/10/27.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeAllPostView: UIView {
    
    let disposeBag = DisposeBag()
    let vm = HomeAllPostViewModel()
    let cellID = "cellID"
    
    let backImg = UIImageView(image: UIImage(named: "homeAllPost")!).then {
        $0.isUserInteractionEnabled = true
    }
    
    let categoryCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.rgb(red: 255, green: 228, blue: 182)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let categoryData = Observable<[String]>.of(["학생 지원", "취업 지원", "창업 지원", "주거 · 금융 지원", "생활 · 복지 지원", "코로나19 지원"])
    let categoryDomy = ["학생 지원", "취업 지원", "창업 지원", "주거 · 금융 지원", "생활 · 복지 지원", "코로나19 지원"]
    
    let countLb = UILabel().then {
        $0.text = "총 68건"
        $0.textColor = UIColor.rgb(red: 171, green: 171, blue: 171)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
    }
    
    let sortTitle = UILabel().then {
        $0.text = "높은 금액순"
        $0.textColor = UIColor.rgb(red: 210, green: 132, blue: 81)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.alpha = 0
    }
    
    let sortBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "filterImg")!, for: .normal)
        $0.alpha = 0
    }
    
    let allPostCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let scrollButton = UIButton(type: .custom).then {
        $0.setTitle("버튼", for: .normal)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setCV()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        addSubview(backImg)
        backImg.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        backImg.addSubview(categoryCV)
        categoryCV.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-45)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        addSubview(countLb)
        countLb.text = "총 \(vm.posts.count)건"
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
        
        addSubview(allPostCV)
        allPostCV.snp.makeConstraints {
            $0.top.equalTo(sortTitle.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-91)
        }
        
    }
    
    func setCV() {
        allPostCV.delegate = self
        allPostCV.dataSource = self
        allPostCV.register(PostCell.self, forCellWithReuseIdentifier: cellID)
        
        categoryCV.delegate = nil
        categoryCV.dataSource = nil
        categoryCV.register(AllPostCategoryCell.self, forCellWithReuseIdentifier: "headerId")
        categoryCV.rx.setDelegate(self).disposed(by: disposeBag)
        categoryData
            .bind(to: categoryCV.rx.items(cellIdentifier: "headerId", cellType: AllPostCategoryCell.self)) { indexPath, title, cell in
                cell.configure(name: title)
        }.disposed(by: disposeBag)
        
        categoryCV.rx.itemSelected
            .map { index in
                let cell = self.categoryCV.cellForItem(at: index) as? AllPostCategoryCell
                return cell?.titleLabel.text ?? ""
            }
            .bind(to: self.vm.input.categoryObserver)
            .disposed(by: disposeBag)
        
        categoryCV.rx.itemSelected
            .subscribe(onNext: { value in
                for i in 0..<self.categoryDomy.count {
                    let cell = self.categoryCV.cellForItem(at: [0, i]) as? AllPostCategoryCell
                    if self.vm.category == self.categoryDomy[i] {
                        cell?.titleLabel.textColor = UIColor.rgb(red: 137, green: 75, blue: 41)
                        cell?.borderView.alpha = 1.0
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
                    } else {
                        cell?.titleLabel.textColor = UIColor.rgb(red: 205, green: 153, blue: 117)
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
                        cell?.borderView.alpha = 0.0
                    }
                }
            }).disposed(by: disposeBag)
        
        vm.output.postChanged.drive(onNext: {value in
            self.countLb.text = "총 \(value)건"
            self.allPostCV.reloadData()
        }).disposed(by: disposeBag)
        
    }
}

extension HomeAllPostView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PostCell
        cell.backgroundColor = UIColor.rgb(red: 255, green: 246, blue: 232)
        cell.configure(vm.posts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == allPostCV {
        HomeChartViewModel.instance.input.postObserver.accept(vm.posts[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == allPostCV ? 17 : 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == allPostCV ? 17 : 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == allPostCV {
            let width = frame.width - 40
            return CGSize(width: width, height: 133)
        } else {
            return AllPostCategoryCell.fittingSize(availableHeight: 21, name: categoryDomy[indexPath.item])
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == allPostCV {
            return UIEdgeInsets(top: 5, left: 20, bottom: 17, right: 20)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollButton.alpha = 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollButton.alpha = 1
    }
    
}


final class AllPostCategoryCell: UICollectionViewCell {
    
    static func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
        let cell = AllPostCategoryCell()
        cell.configure(name: name)
        
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
    let titleLabel: UILabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.rgb(red: 205, green: 153, blue: 117)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
    }
    
    let borderView = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 199, blue: 143)
        $0.layer.cornerRadius = 3.0
        $0.alpha = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    private func setupView() {
        contentView.addSubview(borderView)
        borderView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(name: String?) {
        if name == "학생 지원" {
            borderView.alpha = 1.0
            titleLabel.text = name
            titleLabel.textColor = UIColor.rgb(red: 137, green: 75, blue: 41)
            titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        } else {
            titleLabel.text = name
        }
        
    }
    
}

