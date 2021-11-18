//
//  AddPostCategoryViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/09.
//

import UIKit
import RxSwift
import RxCocoa

class AddPostCategoryViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let vm = AddPostCategoryViewModel()
    
    let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.layoutIfNeeded()
        
        $0.backgroundColor = .white
    }
    
    let titleLb = UILabel().then {
        $0.attributedText = NSAttributedString(string: "추천 받을 복지\n카테고리 선택하기").withLineSpacing(6)
        $0.font = UIFont(name: "GodoM", size: 26)
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.numberOfLines = 2
    }
    
    let studentLb = UILabel().then {
        $0.text = "학생 지원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 20)
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
    }
    
    let studentCV: UICollectionView = {
        let flowLayout = CollectionViewLeftAlignFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let studentData = Observable<[String]>.of(["전체", "교내 장학금", "교외 장학금"])
    let studentDomy = ["전체", "교내 장학금", "교외 장학금"]
    
    let employLb = UILabel().then {
        $0.text = "취업 지원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 20)
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
    }
    
    let employCV: UICollectionView = {
        let flowLayout = CollectionViewLeftAlignFlowLayout()
        flowLayout.estimatedItemSize = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let employData = Observable<[String]>.of(["전체", "구직 활동 지원 · 인턴", "중소 · 중견기업 취업 지원", "특수 분야 취업 지원", "해외 취업 및 진출 지원"])
    let employDomy = ["전체", "구직 활동 지원 · 인턴", "중소 · 중견기업 취업 지원", "특수 분야 취업 지원", "해외 취업 및 진출 지원"]
    
    let startUpLb = UILabel().then {
        $0.text = "창업 지원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 20)
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
    }
    
    let startUpCV: UICollectionView = {
        let flowLayout = CollectionViewLeftAlignFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(AddCategoryCell.self, forCellWithReuseIdentifier: "startUpCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let startUpData = Observable<[String]>.of(["전체", "창업운영 지원", "경영 지원", "자본금 지원"])
    let startUpDomy = ["전체", "창업운영 지원", "경영 지원", "자본금 지원"]
    
    let residentLb = UILabel().then {
        $0.text = "주거 · 금융 지원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 20)
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
    }
    
    let residentCV: UICollectionView = {
        let flowLayout = CollectionViewLeftAlignFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(AddCategoryCell.self, forCellWithReuseIdentifier: "residentCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let residentData = Observable<[String]>.of(["전체", "생활비 지원 · 금융 혜택", "주거 지원", "학자금 지원"])
    let residentDomy = ["전체", "생활비 지원 · 금융 혜택", "주거 지원", "학자금 지원"]
    
    let lifeLb = UILabel().then {
        $0.text = "생활 · 복지 지원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 20)
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
    }
    
    let lifeCV: UICollectionView = {
        let flowLayout = CollectionViewLeftAlignFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(AddCategoryCell.self, forCellWithReuseIdentifier: "lifeCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let lifeData = Observable<[String]>.of(["전체", "건강", "문화"])
    let lifeDomy = ["전체", "건강", "문화"]
    
    let covidLb = UILabel().then {
        $0.text = "코로나19 지원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 20)
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
    }
    
    let covidCV: UICollectionView = {
        let flowLayout = CollectionViewLeftAlignFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(AddCategoryCell.self, forCellWithReuseIdentifier: "covidCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let covidData = Observable<[String]>.of(["전체", "기본소득 지원", "저소득층 지원", "재난피해 지원", "소득 · 일자리 보전", "기타 인센티브", "심리지원"])
    let covidDomy = ["전체", "기본소득 지원", "저소득층 지원", "재난피해 지원", "소득 · 일자리 보전", "기타 인센티브", "심리지원"]
    
    let signUpBt = UIButton(type: .custom).then {
        $0.setTitle("적용하기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = UIColor.rgb(red: 177, green: 177, blue: 177)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 139, bottom: 16, right: 139)
        $0.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
    
    
}

extension AddPostCategoryViewController {
    
    func setUI() {
        
        view.backgroundColor = .white
        safeArea.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1410)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(studentLb)
        studentLb.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(42)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(studentCV)
        studentCV.snp.makeConstraints {
            $0.top.equalTo(studentLb.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.view.frame.width - 40)
            $0.height.equalTo(48)
        }
        
        scrollView.addSubview(employLb)
        employLb.snp.makeConstraints {
            $0.top.equalTo(studentCV.snp.bottom).offset(42)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(employCV)
        employCV.snp.makeConstraints {
            $0.top.equalTo(employLb.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(self.view.frame.width - 46)
            $0.height.equalTo(176)
        }
        
        scrollView.addSubview(startUpLb)
        startUpLb.snp.makeConstraints {
            $0.top.equalTo(employCV.snp.bottom).offset(42)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(startUpCV)
        startUpCV.snp.makeConstraints {
            $0.top.equalTo(startUpLb.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(240)
            $0.height.equalTo(112)
        }
        
        scrollView.addSubview(residentLb)
        residentLb.snp.makeConstraints {
            $0.top.equalTo(startUpCV.snp.bottom).offset(42)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(residentCV)
        residentCV.snp.makeConstraints {
            $0.top.equalTo(residentLb.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(260)
            $0.height.equalTo(112)
        }
        
        scrollView.addSubview(lifeLb)
        lifeLb.snp.makeConstraints {
            $0.top.equalTo(residentCV.snp.bottom).offset(42)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(lifeCV)
        lifeCV.snp.makeConstraints {
            $0.top.equalTo(lifeLb.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(self.view.frame.width - 40)
            $0.height.equalTo(48)
        }
        
        scrollView.addSubview(covidLb)
        covidLb.snp.makeConstraints {
            $0.top.equalTo(lifeCV.snp.bottom).offset(42)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(covidCV)
        covidCV.snp.makeConstraints {
            $0.top.equalTo(covidLb.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(self.view.frame.width - 46)
            $0.height.equalTo(176)
        }
        
        scrollView.addSubview(signUpBt)
        signUpBt.snp.makeConstraints {
            $0.top.equalTo(covidCV.snp.bottom).offset(42)
            $0.centerX.equalToSuperview()
        }
        
        
    }
    
    func bind() {
        studentCV.delegate = nil
        studentCV.dataSource = nil
        studentCV.register(AddCategoryCell.self, forCellWithReuseIdentifier: "studentCell")
        studentCV.rx.setDelegate(self).disposed(by: disposeBag)
        studentData
            .bind(to: self.studentCV.rx.items(cellIdentifier: "studentCell", cellType: AddCategoryCell.self)) { indexPath, title, cell in
                cell.configure(name: title)
            }.disposed(by: disposeBag)
        
        studentCV.rx.itemSelected
            .map { index in
                let cell = self.studentCV.cellForItem(at: index) as? AddCategoryCell
                return cell?.titleLabel.text ?? ""
            }
            .bind(to: self.vm.input.studentObserver)
            .disposed(by: disposeBag)
        
        studentCV.rx.itemSelected
            .subscribe(onNext: { value in
                for i in 0..<self.studentDomy.count {
                    let cell = self.studentCV.cellForItem(at: [0, i]) as? AddCategoryCell
                    if self.vm.user.studentCategory.contains(self.studentDomy[i]) {
                        cell?.titleLabel.textColor = .white
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
                        cell?.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
                    } else {
                        cell?.titleLabel.textColor = UIColor.rgb(red: 108, green: 108, blue: 108)
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
                        cell?.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
                    }
                }
            }).disposed(by: disposeBag)
        
        
        
        
        employCV.delegate = nil
        employCV.dataSource = nil
        employCV.register(AddCategoryCell.self, forCellWithReuseIdentifier: "employCell")
        employCV.rx.setDelegate(self).disposed(by: disposeBag)
        employData
            .bind(to: self.employCV.rx.items(cellIdentifier: "employCell", cellType: AddCategoryCell.self)) { indexPath, title, cell in
                cell.configure(name: title)
            }.disposed(by: disposeBag)
        
        employCV.rx.itemSelected
            .map { index in
                let cell = self.employCV.cellForItem(at: index) as? AddCategoryCell
                return cell?.titleLabel.text ?? ""
            }
            .bind(to: self.vm.input.empolyObserver)
            .disposed(by: disposeBag)
        
        employCV.rx.itemSelected
            .subscribe(onNext: { value in
                for i in 0..<self.employDomy.count {
                    let cell = self.employCV.cellForItem(at: [0, i]) as? AddCategoryCell
                    if self.vm.user.empolyCategory.contains(self.employDomy[i]) {
                        cell?.titleLabel.textColor = .white
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
                        cell?.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
                    } else {
                        cell?.titleLabel.textColor = UIColor.rgb(red: 108, green: 108, blue: 108)
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
                        cell?.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
                    }
                }
            }).disposed(by: disposeBag)
        
        startUpCV.delegate = nil
        startUpCV.dataSource = nil
        startUpCV.rx.setDelegate(self).disposed(by: disposeBag)
        startUpData
            .bind(to: self.startUpCV.rx.items(cellIdentifier: "startUpCell", cellType: AddCategoryCell.self)) { indexPath, title, cell in
                cell.configure(name: title)
            }.disposed(by: disposeBag)
        
        startUpCV.rx.itemSelected
            .map { index in
                let cell = self.startUpCV.cellForItem(at: index) as? AddCategoryCell
                return cell?.titleLabel.text ?? ""
            }
            .bind(to: self.vm.input.foundationObserver)
            .disposed(by: disposeBag)
        
        startUpCV.rx.itemSelected
            .subscribe(onNext: { value in
                for i in 0..<self.startUpDomy.count {
                    let cell = self.startUpCV.cellForItem(at: [0, i]) as? AddCategoryCell
                    if self.vm.user.foundationCategory.contains(self.startUpDomy[i]) {
                        cell?.titleLabel.textColor = .white
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
                        cell?.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
                    } else {
                        cell?.titleLabel.textColor = UIColor.rgb(red: 108, green: 108, blue: 108)
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
                        cell?.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
                    }
                }
            }).disposed(by: disposeBag)
        
        residentCV.delegate = nil
        residentCV.dataSource = nil
        residentCV.rx.setDelegate(self).disposed(by: disposeBag)
        residentData
            .bind(to: self.residentCV.rx.items(cellIdentifier: "residentCell", cellType: AddCategoryCell.self)) { indexPath, title, cell in
                cell.configure(name: title)
            }.disposed(by: disposeBag)
        
        residentCV.rx.itemSelected
            .map { index in
                let cell = self.residentCV.cellForItem(at: index) as? AddCategoryCell
                return cell?.titleLabel.text ?? ""
            }
            .bind(to: self.vm.input.residentObserver)
            .disposed(by: disposeBag)
        
        residentCV.rx.itemSelected
            .subscribe(onNext: { value in
                for i in 0..<self.residentDomy.count {
                    let cell = self.residentCV.cellForItem(at: [0, i]) as? AddCategoryCell
                    if self.vm.user.residentCategory.contains(self.residentDomy[i]) {
                        cell?.titleLabel.textColor = .white
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
                        cell?.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
                    } else {
                        cell?.titleLabel.textColor = UIColor.rgb(red: 108, green: 108, blue: 108)
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
                        cell?.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
                    }
                }
            }).disposed(by: disposeBag)
        
        lifeCV.delegate = nil
        lifeCV.dataSource = nil
        lifeCV.rx.setDelegate(self).disposed(by: disposeBag)
        lifeData
            .bind(to: self.lifeCV.rx.items(cellIdentifier: "lifeCell", cellType: AddCategoryCell.self)) { indexPath, title, cell in
                cell.configure(name: title)
            }.disposed(by: disposeBag)
        
        lifeCV.rx.itemSelected
            .map { index in
                let cell = self.lifeCV.cellForItem(at: index) as? AddCategoryCell
                return cell?.titleLabel.text ?? ""
            }
            .bind(to: self.vm.input.lifeObserver)
            .disposed(by: disposeBag)
        
        lifeCV.rx.itemSelected
            .subscribe(onNext: { value in
                for i in 0..<self.lifeDomy.count {
                    let cell = self.lifeCV.cellForItem(at: [0, i]) as? AddCategoryCell
                    if self.vm.user.lifeCategory.contains(self.lifeDomy[i]) {
                        cell?.titleLabel.textColor = .white
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
                        cell?.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
                    } else {
                        cell?.titleLabel.textColor = UIColor.rgb(red: 108, green: 108, blue: 108)
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
                        cell?.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
                    }
                }
            }).disposed(by: disposeBag)
        
        covidCV.delegate = nil
        covidCV.dataSource = nil
        covidCV.rx.setDelegate(self).disposed(by: disposeBag)
        covidData
            .bind(to: self.covidCV.rx.items(cellIdentifier: "covidCell", cellType: AddCategoryCell.self)) { indexPath, title, cell in
                cell.configure(name: title)
            }.disposed(by: disposeBag)
        
        covidCV.rx.itemSelected
            .map { index in
                let cell = self.covidCV.cellForItem(at: index) as? AddCategoryCell
                return cell?.titleLabel.text ?? ""
            }
            .bind(to: self.vm.input.covidObserver)
            .disposed(by: disposeBag)
        
        covidCV.rx.itemSelected
            .subscribe(onNext: { value in
                for i in 0..<self.covidDomy.count {
                    let cell = self.covidCV.cellForItem(at: [0, i]) as? AddCategoryCell
                    if self.vm.user.covidCategory.contains(self.covidDomy[i]) {
                        cell?.titleLabel.textColor = .white
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
                        cell?.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
                    } else {
                        cell?.titleLabel.textColor = UIColor.rgb(red: 108, green: 108, blue: 108)
                        cell?.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
                        cell?.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
                    }
                }
            }).disposed(by: disposeBag)
        
        vm.output.buttonValid.drive(onNext: {value in
            if value {
                print(self.vm.user)
                self.signUpBt.isEnabled = true
                self.signUpBt.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
            } else {
                self.signUpBt.backgroundColor = UIColor.rgb(red: 177, green: 177, blue: 177)
                self.signUpBt.isEnabled = false
            }
        }).disposed(by: disposeBag)
        
        signUpBt.rx.tap
            .bind(to: vm.input.btObserver)
            .disposed(by: disposeBag)
        
        vm.output.goSignUp
            .emit { user in
                print(user)
            }.disposed(by: disposeBag)
        
        vm.output.error
            .emit { error in
                print(error)
            }.disposed(by: disposeBag)
    }
    
}

extension AddPostCategoryViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == studentCV {
            return AddCategoryCell.fittingSize(availableHeight: 45, name: studentDomy[indexPath.item])
        } else if collectionView == employCV {
            return AddCategoryCell.fittingSize(availableHeight: 45, name: employDomy[indexPath.item])
        } else if collectionView == startUpCV {
            return AddCategoryCell.fittingSize(availableHeight: 45, name: startUpDomy[indexPath.item])
        } else if collectionView == residentCV {
            return AddCategoryCell.fittingSize(availableHeight: 45, name: residentDomy[indexPath.item])
        } else if collectionView == lifeCV {
            return AddCategoryCell.fittingSize(availableHeight: 45, name: lifeDomy[indexPath.item])
        } else {
            return AddCategoryCell.fittingSize(availableHeight: 45, name: covidDomy[indexPath.item])
        }
    }
    
    
}


final class AddCategoryCell: UICollectionViewCell {
    
    static func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
        let cell = AddCategoryCell()
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
        layer.cornerRadius = 22.0
    }
    
    private func setupView() {
        backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.rgb(red: 108, green: 108, blue: 108)
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-14)
        }
    }
    
    func configure(name: String?) {
        titleLabel.text = name
    }
    
}


class CollectionViewLeftAlignFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 16
 
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 16.0
        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let attributes = super.layoutAttributesForElements(in: rect)
 
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
