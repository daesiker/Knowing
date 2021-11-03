//
//  AddressViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/03.
//

import UIKit
import RxCocoa
import RxSwift

let address:[String: [String]] = ["시/도 선택":["서울특별시", "부산광역시", "대구광역시", "인천광역시", "광주광역시", "대전광역시", "울산광역시", "경기도", "강원도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주특별자치도", "세종특별자치시"],
                                  "서울특별시": ["강남구", "강동구", "강서구", "강북구", "관악구", "광진구", "구로구", "금천구", "노원구", "동대문구", "도봉구", "동작구", "마포구", "서대문구", "성동구", "성북구", "서초구", "송파구", "영등포구", "용산구", "양천구", "은평구", "종로구", "중구", "중랑구"],
                                  "부산광역시": ["중구", "서구", "동구", "영도구", "부산진구", "동래구", "남구", "북구", "해운대구", "사하구", "금정구", "강서구", "연제구", "수영구", "사상구", "기장군"],
                                  "대구광역시": ["북구", "동구", "중구", "서구", "달서구", "수성구", "남구", "달성군"],
                                  "인천광역시": ["계양구", "미주홀구", "연수구", "남동구", "부평구", "중구", "동구", "서구"],
                                  "광주광역시": ["동구", "서구", "남구", "북구", "광산구"],
                                  "대전광역시": ["대덕구", "동구", "서구", "유성구", "중구"],
                                  "울산광역시": ["중구", "남구", "북구", "동구", "울주군"],
                                  "제주특별자치도": ["제주시", "서귀포시"],
                                  "세종특별자치시": ["세종시"]]

class AddressViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let cancelBt = UIBarButtonItem(image: UIImage(named: "largeCancel"), style: .plain, target: nil, action: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
    func setUI() {
        view.backgroundColor = .white
        navigationController?.title = "시/도 선택"
        navigationController?.navigationItem.rightBarButtonItem = cancelBt
    }
    
    func bind() {
        cancelBt.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    
    
}
