//
//  AddressViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/03.
//

import UIKit
import RxCocoa
import RxSwift
import PanModal

let address:[String: [String]] = ["시/도 선택" :
                                    ["서울특별시", "부산광역시", "대구광역시", "인천광역시", "광주광역시", "대전광역시", "울산광역시", "경기도", "강원도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주특별자치도", "세종특별자치시"],
                                  "서울특별시":
                                    ["강남구", "강동구", "강서구", "강북구", "관악구", "광진구", "구로구", "금천구", "노원구", "동대문구", "도봉구", "동작구", "마포구", "서대문구", "성동구", "성북구", "서초구", "송파구", "영등포구", "용산구", "양천구", "은평구", "종로구", "중구", "중랑구"],
                                  "부산광역시":
                                    ["중구", "서구", "동구", "영도구", "부산진구", "동래구", "남구", "북구", "해운대구", "사하구", "금정구", "강서구", "연제구", "수영구", "사상구", "기장군"],
                                  "대구광역시":
                                    ["북구", "동구", "중구", "서구", "달서구", "수성구", "남구", "달성군"],
                                  "인천광역시":
                                    ["계양구", "미주홀구", "연수구", "남동구", "부평구", "중구", "동구", "서구"],
                                  "광주광역시": ["동구", "서구", "남구", "북구", "광산구"],
                                  "대전광역시": ["대덕구", "동구", "서구", "유성구", "중구"],
                                  "울산광역시": ["중구", "남구", "북구", "동구", "울주군"],
                                  "제주특별자치도": ["제주시", "서귀포시"],
                                  "세종특별자치시": ["세종시"],
                                  "경기도": ["수원시","성남시","의정부시","안양시","부천시","광명시","평택시","동두천시","안산시","고양시","과천시","구리시","남양주시","오산시 ","시흥시 ","군포시","의왕시","하남시",
                                                "용인시","파주시","이천시","안성시","김포시","화성시","광주시","양주시","포천시","여주시","양주군","여주군","연천군","포천군","가평군","양평군"],
                                  "강원도": ["춘천시","원주시","강릉시","동해시","태백시","속초시","삼척시","홍천군","횡성군","영월군","평창군","정선군","철원군","화천군","양구군","인제군","고성군 ","양양군"],
                                  "충청북도": ["청주시","충주시","제천시","청원군","보은군","옥천군","영동군","증평군","진천군","괴산군","음성군","단양군"],
                                  "충청남도": ["천안시","공주시","보령시","아산시","서산시","논산시","계룡시","당진시","금산군","연기군","부여군","서천군","청양군","홍성군","예산군","태안군","당진군"],
                                  "전라북도": ["전주시","군산시","익산시","정읍시","남원시","김제시","완주군","진안군","무주군","장수군","임실군","순창군","고창군","부안군"],
                                  "전라남도": ["목포시","여수시","순천시","나주시","광양시","담양군","곡성군","구례군","고흥군","보성군","화순군","장흥군","강진군","해남군","영암군","무안군","함평군","영광군","장성군","완도군","진도군","신안군"],
                                  "경상북도": ["포항시","경주시","김천시","안동시","구미시","영주시","영천시","상주시","문경시","경산시","군위군","의성군","청송군","영양군","영덕군","청도군","고령군","성주군","칠곡군","예천군","봉화군","울진군","울릉군"],
                                  "경상남도": ["창원시","마산시","진주시","진해시","통영시","사천시","김해시","밀양시","거제시","양산시","의령군","함안군","창녕군","고성군","남해군","하동군","산청군","함양군","거창군","합천군"]]


class AddressViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let vm = ExtraSignUpViewModel.instance
    
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
    
    let cellId = "cellId"
    var allItem = address["시/도 선택"] ?? []
    var selectedItem = Observable<[String]>.of(address["시/도 선택"] ?? [])
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
            $0.top.equalTo(separator.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
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
            .bind(to: self.isCity ? vm.stepOne.input.cityValueObserver : vm.stepOne.input.guValueObserver)
            .disposed(by: disposeBag)
        
    }
    
    
}

extension AddressViewController: PanModalPresentable {
    
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

extension AddressViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 25, bottom: 15, right: 25)
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


class AddressCell: UICollectionViewCell {
    
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
    
}


