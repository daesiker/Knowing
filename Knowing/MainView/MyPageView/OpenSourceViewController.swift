//
//  OpenSourceViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/30.
//

import UIKit
import RxSwift
import RxCocoa

class OpenSourceViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    lazy var scrollView = UIScrollView(frame: .zero).then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.frame = UIScreen.main.bounds
        $0.backgroundColor = .white
    }
    
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let titleLb = UILabel().then {
        $0.text = "오픈소스 라이선스"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "GodoM", size: 18)
    }
    
    let separator = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
    }
    
    let sourceLb1 = UILabel().then {
        $0.text = "Lottiefiles"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
    }
    
    let sourceDetailLb1 = UILabel().then {
        $0.text = "Animation by Jignesh Gajjar on LottieFiles\nJignesh Gajjar on LottieFiles: https://lottiefiles.com/71185-ui-ux\n\nAnimation by Splash Animation on LottieFiles\nSplash Animation on LottieFiles: https://lottiefiles.com/20946-message-email-opening-animation\n\nAnimation by Jessi Conoyer on LottieFiles\nJessi Conoyer on LottieFiles: https://lottiefiles.com/67142-check"
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.numberOfLines = 0
    }
    
    let sourceLb2 = UILabel().then {
        $0.text = "Freepik"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
    }
    
    let sourceDetailLb2 = UILabel().then {
        $0.text = "<a href=\"https://www.freepik.com/vectors/people\">People vector created by freepik - www.freepik.com</a>\n\n<a href=\"https://www.freepik.com/vectors/christmas\">Christmas vector created by freepik - www.freepik.com</a>\n\n<a href=\"https://www.freepik.com/vectors/sale\">Sale vector created by vectorjuice - www.freepik.com</a>\n\n<a href=\"http://www.freepik.com\">Designed by gstudioimagen / Freepik</a>\n\n<a href=\"https://www.freepik.com/vectors/people\">People vector created by stories - www.freepik.com</a>\n\n<a href=\"https://www.freepik.com/vectors/data\">Data vector created by stories - www.freepik.com</a>\n\n<a href=\"https://www.freepik.com/vectors/mobile\">Mobile vector created by stories - www.freepik.com</a>"
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.numberOfLines = 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        backBt.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        safeArea.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(backBt)
        backBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(12)
        }
        
        scrollView.addSubview(separator)
        separator.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(safeArea.snp.trailing)
            $0.height.equalTo(2)
        }
        
        scrollView.addSubview(sourceLb1)
        sourceLb1.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(31)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(sourceDetailLb1)
        sourceDetailLb1.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.top.equalTo(sourceLb1.snp.bottom).offset(13)
        }
        
        scrollView.addSubview(sourceLb2)
        sourceLb2.snp.makeConstraints {
            $0.top.equalTo(sourceDetailLb1.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(sourceDetailLb2)
        sourceDetailLb2.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.top.equalTo(sourceLb2.snp.bottom).offset(13)
        }
        
        scrollView.layoutIfNeeded()
        
        scrollView.updateContentSize()
        
    }

   

}
