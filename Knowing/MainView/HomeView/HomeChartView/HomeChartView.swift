//
//  HomeChartView.swift
//  Knowing
//
//  Created by Jun on 2021/10/27.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class HomeChartView: UIView {
    
    let disposeBag = DisposeBag()
    let cellID = "cellID"
    let headerID = "headerID"
    let vm = HomeChartViewModel.instance
    var sortType:SortType = .maxMoney
    
    let chartCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.rgb(red: 255, green: 245, blue: 230)
        return collectionView
    }()
    
    let imgView = UIImageView(image: UIImage(named: "slice1")!)
    let imgView2 = UIImageView(image: UIImage(named: "slice2")!)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sort(sortType)
        setCV()
        bind()
        addSubview(chartCV)
        chartCV.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-91)
        }
        
        addSubview(imgView)
        imgView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        addSubview(imgView2)
        imgView2.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension HomeChartView {
    
    func setCV() {
        chartCV.delegate = self
        chartCV.dataSource = self
        chartCV.register(PostCell.self, forCellWithReuseIdentifier: cellID)
        chartCV.register(HomeChartHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    }
    
    func bind() {
        vm.output.postChanged.drive(onNext: {value in
            self.sort(self.sortType)
            self.chartCV.reloadData()
        }).disposed(by: disposeBag)
        
        vm.output.goChartSort.drive(onNext: { value in
            self.sort(value)
            self.chartCV.reloadData()
        }).disposed(by: disposeBag)
        
        vm.output.getBottomBt.drive(onNext: {
            self.chartCV.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }).disposed(by: disposeBag)
        
    }
    
    func sort(_ option: SortType) {
        sortType = option
        
        switch option {
        case .maxMoney:
            self.vm.posts.sort(by: { a, b in
                return Int(a.maxMoney)! > Int(b.maxMoney)!
            })
            self.chartCV.reloadData()
        case .minMoney:
            self.vm.posts.sort(by: { a, b in
                return Int(a.maxMoney)! < Int(b.maxMoney)!
            })
            self.chartCV.reloadData()
        case .lastestDate:
            self.vm.posts.sort(by: { prev, next in
                
                
                let prevTmp = prev.applyDate.components(separatedBy: "~")
                let nextTmp = next.applyDate.components(separatedBy: "~")
                
                let prevDate = prevTmp.count == 2 ? Int(prevTmp[1].replacingOccurrences(of: ".", with: "")) ?? 0 : 99999999
                let nextDate = nextTmp.count == 2 ? Int(nextTmp[1].replacingOccurrences(of: ".", with: "")) ?? 0 : 99999999
                
                return prevDate < nextDate
            })
            self.chartCV.reloadData()
        
        }
    }
    
}


extension HomeChartView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        vm.input.postObserver.accept(self.vm.posts[indexPath.row])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PostCell
        cell.backgroundColor = .white
        cell.configure(vm.posts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! HomeChartHeader
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
        return CGSize(width: width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = frame.width
        return CGSize(width: width, height: 710)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 21, left: 20, bottom: 17, right: 20)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > 70 {
            self.vm.input.bottomAlphaObserver.accept(true)
        } else {
            self.vm.input.bottomAlphaObserver.accept(false)
        }
        
    }
    
    
    
}

class HomeChartHeader: UICollectionViewCell {
    
    let vm = HomeChartViewModel.instance
    let disposeBag = DisposeBag()
    
    let imgView = UIImageView(image: UIImage(named: "chartView")!).then {
        $0.isUserInteractionEnabled = true
    }
    
    let titleLb = UILabel().then {
        $0.text = "리즈님의 최대 수혜 금액"
        $0.font = UIFont(name: "GodoM", size: 17)
        $0.textColor = UIColor.rgb(red: 164, green: 97, blue: 61)
    }
    
    let maxMoneyLb = UILabel().then {
        $0.text = "250,000"
        $0.font = UIFont(name: "GodoB", size: 42)
        $0.textColor = UIColor.rgb(red: 185, green: 113, blue: 66)
    }
    
    let maxWonLb = UILabel().then {
        $0.text = "원"
        $0.textColor = UIColor.rgb(red: 180, green: 122, blue: 91)
        $0.font = UIFont(name: "GodoB", size: 20)
    }
    
    let maxMoneyBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "goMoney")!, for: .normal)
    }
    
    let minMoneyLb = UILabel().then {
        $0.text = "최소 80,000원"
        $0.textColor = UIColor.rgb(red: 210, green: 132, blue: 81)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
    }
    
    let chartTitleLb = UILabel().then {
        $0.text = "수혜 예상 복지"
        $0.textColor = UIColor.rgb(red: 164, green: 97, blue: 61)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
    }
    
    let chartBorder = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 198, blue: 141)
    }
    
    let chartCount = UILabel().then {
        $0.text = "50건"
        $0.textColor = UIColor.rgb(red: 164, green: 97, blue: 61)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
    }
    
    let chartView = ChartView()
    
    let cvTitle = UILabel().then {
        $0.text = "카테고리별 맞춤 복지"
        $0.textColor = UIColor.rgb(red: 164, green: 97, blue: 61)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
    }
    
    let cvUnderLine = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 198, blue: 141)
    }
    
    let sortTitle = UILabel().then {
        $0.text = "높은 금액순"
        $0.textColor = UIColor.rgb(red: 210, green: 132, blue: 81)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
    }
    
    let sortBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "filterImg")!, for: .normal)
        
    }
    
    let categoryCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.rgb(red: 255, green: 245, blue: 230)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let categoryData = Observable<[String]>.of(["학생 지원", "취업 지원", "창업 지원", "주거 · 금융 지원", "생활 · 복지 지원", "코로나19 지원"])
    let categoryDomy = ["학생 지원", "취업 지원", "창업 지원", "주거 · 금융 지원", "생활 · 복지 지원", "코로나19 지원"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle()
        chartView.chartAnimation()
        setCV()
        setUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle() {
        titleLb.text = "\(vm.main.user.name)님의 최대 수혜 금액"
        let posts = vm.main.posts["myPost"] ?? []
        if posts.count != 0 {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            var price = Int(posts[0].maxMoney) ?? 0
            var result = numberFormatter.string(from: NSNumber(value:price))!
            maxMoneyLb.text = result
            if posts.count >= 2 {
                price = Int(posts.last!.minMoney) ?? 0
                result = numberFormatter.string(from: NSNumber(value:price))!
                minMoneyLb.text = "최소 \(result)원"
            } else {
                minMoneyLb.text = "최소 0원"
            }
            
        } else {
            maxMoneyLb.text = "0"
            minMoneyLb.text = "최소 0원"
        }
        
        //maxMoneyLb.text = vm.main.posts["myPost"]!.first!.maxMoney
        //minMoneyLb.text = "최소 \(vm.main.posts["myPost"]!.last!.minMoney)원"
        chartCount.text = "\(vm.main.posts["myPost"]!.count)건"
    }
    
    func setUI() {
        backgroundColor = UIColor.rgb(red: 255, green: 245, blue: 230)
        addSubview(imgView)
        imgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(299)
        }

        imgView.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(134)
            $0.centerX.equalToSuperview()
        }

        imgView.addSubview(maxMoneyLb)
        maxMoneyLb.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-13)
            $0.top.equalTo(titleLb.snp.bottom).offset(11)
        }

        imgView.addSubview(maxWonLb)
        maxWonLb.snp.makeConstraints {
            $0.top.equalTo(maxMoneyLb.snp.top).offset(12)
            $0.leading.equalTo(maxMoneyLb.snp.trailing).offset(2)

        }

        imgView.addSubview(maxMoneyBt)
        maxMoneyBt.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(12)
            $0.leading.equalTo(maxWonLb.snp.trailing).offset(2)
        }

        imgView.addSubview(minMoneyLb)
        minMoneyLb.snp.makeConstraints {
            $0.top.equalTo(maxMoneyBt.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }

        addSubview(chartTitleLb)
        chartTitleLb.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
        }

        addSubview(chartCount)
        chartCount.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom)
            $0.leading.equalTo(chartTitleLb.snp.trailing).offset(7)
        }

        addSubview(chartBorder)
        chartBorder.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom).offset(12)
            $0.leading.equalTo(chartTitleLb.snp.trailing).offset(7)
            $0.width.equalTo(chartCount.snp.width)
            $0.height.equalTo(8)

        }
        bringSubviewToFront(chartCount)
        
        addSubview(chartView)
        chartView.snp.makeConstraints {
            $0.top.equalTo(chartTitleLb.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(246)
        }

        addSubview(cvUnderLine)
        cvUnderLine.snp.makeConstraints {
            $0.top.equalTo(chartView.snp.bottom).offset(53)
            $0.leading.equalToSuperview().offset(101)
            $0.height.equalTo(7)
            $0.width.equalTo(64)
        }

        addSubview(cvTitle)
        cvTitle.snp.makeConstraints {
            $0.top.equalTo(chartView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20.5)
        }

        addSubview(sortBt)
        sortBt.snp.makeConstraints {
            $0.top.equalTo(chartView.snp.bottom).offset(32)
            $0.trailing.equalToSuperview().offset(-12)
        }

        addSubview(sortTitle)
        sortTitle.snp.makeConstraints {
            $0.top.equalTo(chartView.snp.bottom).offset(41)
            $0.trailing.equalTo(sortBt.snp.leading)
        }
        
        addSubview(categoryCV)
        categoryCV.snp.makeConstraints {
            $0.top.equalTo(cvTitle.snp.bottom).offset(23)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(35)
        }
    }
    
    func bind() {
        maxMoneyBt.rx.tap.subscribe(onNext: {
            if self.maxMoneyLb.text != "0" {
                let posts = self.vm.main.posts["myPost"] ?? []
                self.vm.input.postObserver.accept(posts[0])
            }
        }).disposed(by: disposeBag)
        
        sortBt.rx.tap.bind(to: vm.input.chartBtObserver).disposed(by: disposeBag)
        
        vm.output.goChartSort.drive(onNext: {value in
            self.sortTitle.text = value.rawValue
        }).disposed(by: disposeBag)
        
        
    }
    
    
    func setCV() {
        categoryCV.delegate = nil
        categoryCV.dataSource = nil
        categoryCV.register(HomeCategoryCell.self, forCellWithReuseIdentifier: "cellId")
        categoryCV.rx.setDelegate(self).disposed(by: disposeBag)
        categoryData
            .bind(to: categoryCV.rx.items(cellIdentifier: "cellId", cellType: HomeCategoryCell.self)) { indexPath, title, cell in
                cell.configure(name: title)
        }.disposed(by: disposeBag)
        
        categoryCV.rx.itemSelected
            .map { index in
                let cell = self.categoryCV.cellForItem(at: index) as? HomeCategoryCell
                return cell?.titleLabel.text ?? ""
            }
            .bind(to: self.vm.input.categoryObserver)
            .disposed(by: disposeBag)
        
        categoryCV.rx.itemSelected
            .subscribe(onNext: { value in
                for i in 0..<self.categoryDomy.count {
                    let cell = self.categoryCV.cellForItem(at: [0, i]) as? HomeCategoryCell
                    if self.vm.category == self.categoryDomy[i] {
                        cell?.titleLabel.textColor = .white
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
                        cell?.backgroundColor = UIColor.rgb(red: 255, green: 152, blue: 87)
                    } else {
                        cell?.titleLabel.textColor = UIColor.rgb(red: 210, green: 132, blue: 81)
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 17)
                        cell?.backgroundColor = UIColor.rgb(red: 255, green: 232, blue: 194)
                    }
                }
            }).disposed(by: disposeBag)
        
        
    }
    
}

extension HomeChartHeader: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return HomeCategoryCell.fittingSize(availableHeight: 33, name: categoryDomy[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
}




final class HomeCategoryCell: UICollectionViewCell {
    
    static func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
        let cell = HomeCategoryCell()
        cell.configure(name: name)
        
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
    
    let titleLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 16
    }
    
    private func setupView() {
        backgroundColor = UIColor.rgb(red: 255, green: 232, blue: 194)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.rgb(red: 210, green: 132, blue: 81)
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 17)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(11)
            $0.trailing.equalToSuperview().offset(-11)
            $0.bottom.equalToSuperview().offset(-6)
        }
    }
    
    func configure(name: String?) {
        if name == "학생 지원" {
            backgroundColor = UIColor.rgb(red: 255, green: 152, blue: 87)
            titleLabel.textColor = .white
            titleLabel.text = name
        } else {
            titleLabel.text = name
        }
        
    }
    
}
