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
    
    let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
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
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 25)
        flowLayout.minimumLineSpacing = 17
        flowLayout.minimumInteritemSpacing = 17
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(AddCategoryCell.self, forCellWithReuseIdentifier: "studentCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let studentData = Observable<[String]>.of(["전체", "교내 장학금", "교외 장학금"])
    
    let employLb = UILabel().then {
        $0.text = "취업 지원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 20)
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
    }
    
    let employCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(AddCategoryCell.self, forCellWithReuseIdentifier: "employCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let employData = Observable<[String]>.of(["전체", "구직 활동 지원 · 인턴", "중소 · 중견기업 취업 지원", "특수 분야 취업 지원", "해외 취업 및 진출 지원"])
    
    let startUpLb = UILabel().then {
        $0.text = "창업 지원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 20)
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
    }
    
    let startUpCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(AddCategoryCell.self, forCellWithReuseIdentifier: "startUpCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let startUpData = Observable<[String]>.of(["전체", "창업운영 지원", "경영 지원", "자본금 지원"])
    
    let residentLb = UILabel().then {
        $0.text = "주거 · 금융 지원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 20)
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
    }
    
    let residentCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(AddCategoryCell.self, forCellWithReuseIdentifier: "residentCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let residentData = Observable<[String]>.of(["전체", "생활비 지원 · 금융 혜택", "주거 지원", "학자금 지원"])
    
    let lifeLb = UILabel().then {
        $0.text = "생활 · 복지 지원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 20)
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
    }
    
    let lifeCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(AddCategoryCell.self, forCellWithReuseIdentifier: "lifeCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let lifeData = Observable<[String]>.of(["전체", "건강", "문화"])
    
    let covidLb = UILabel().then {
        $0.text = "코로나19 지원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 20)
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
    }
    
    let covidCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(AddCategoryCell.self, forCellWithReuseIdentifier: "covidCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let covidData = Observable<[String]>.of(["전체", "기본소득 지원", "저소득층 지원", "재난피해 지원", "소득 · 일자리 보전", "기타 인센티브", "심리지원"])
    
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
            $0.top.equalToSuperview().offset(42)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(studentCV)
        studentCV.snp.makeConstraints {
            $0.top.equalTo(studentLb.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
        }
        
        
    }
    
    func bind() {
        studentCV.delegate = nil
        studentCV.dataSource = nil
        studentCV.rx.setDelegate(self).disposed(by: disposeBag)
        studentData
            .bind(to: self.studentCV.rx.items(cellIdentifier: "studentCell", cellType: AddCategoryCell.self)) { indexPath, title, cell in
                cell.text.text = title
            }.disposed(by: disposeBag)
        
        employData
            .bind(to: self.studentCV.rx.items(cellIdentifier: "employCell", cellType: AddCategoryCell.self)) { indexPath, title, cell in
                cell.text.text = title
            }.disposed(by: disposeBag)
        
        startUpData
            .bind(to: self.studentCV.rx.items(cellIdentifier: "startUpCell", cellType: AddCategoryCell.self)) { indexPath, title, cell in
                cell.text.text = title
            }.disposed(by: disposeBag)
        
        residentData
            .bind(to: self.studentCV.rx.items(cellIdentifier: "residentCell", cellType: AddCategoryCell.self)) { indexPath, title, cell in
                cell.text.text = title
            }.disposed(by: disposeBag)
        
        lifeData
            .bind(to: self.studentCV.rx.items(cellIdentifier: "lifeCell", cellType: AddCategoryCell.self)) { indexPath, title, cell in
                cell.text.text = title
            }.disposed(by: disposeBag)
        
        covidData
            .bind(to: self.studentCV.rx.items(cellIdentifier: "covidCell", cellType: AddCategoryCell.self)) { indexPath, title, cell in
                cell.text.text = title
            }.disposed(by: disposeBag)
    }
    
    
}

extension AddPostCategoryViewController: UICollectionViewDelegate {
    
}




class AddCategoryCell: UICollectionViewCell {
    
    let view = UIView().then {
        $0.layer.cornerRadius = 22.0
        $0.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
    }
    
    let text = UILabel().then {
        $0.text = ""
        $0.font = UIFont.init(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.textColor = UIColor.rgb(red: 108, green: 108, blue: 108)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(text)
        text.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.bottom.equalToSuperview().offset(-14)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-26)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
