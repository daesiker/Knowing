//
//  HomeViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/20.
//

import UIKit
import Foundation
import Then
import RxSwift
import RxCocoa
import BetterSegmentedControl

class HomeViewController: UIViewController  {
    
    let chartVM = HomeChartViewModel.instance
    var goToAllView = false
    var posts:[String:[Post]] = [:]
    var user:User = User()
    var disposedBag = DisposeBag()
    
    let homeScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.alwaysBounceVertical = false
        $0.isScrollEnabled = false
    }
    
    let homeSegmentedControl = BetterSegmentedControl(frame: .zero, segments: LabelSegment.segments(withTitles: ["맞춤 복지", "나의 캘린더", "모든 복지"], numberOfLines: 1, normalBackgroundColor: UIColor.rgb(red: 252, green: 245, blue: 235), normalFont: UIFont.init(name: "AppleSDGothicNeo-Bold", size: 16), normalTextColor: UIColor.rgb(red: 139, green: 139, blue: 139), selectedBackgroundColor: UIColor.rgb(red: 255, green: 152, blue: 87), selectedFont: UIFont.init(name: "AppleSDGothicNeo-Bold", size: 16), selectedTextColor: .white), options: [.cornerRadius(25), .indicatorViewInset(5), .backgroundColor(UIColor.rgb(red: 252, green: 245, blue: 235))])
    
    let scrollToTopBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "scrollToTop")!, for: .normal)
        $0.alpha = 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lightMode()
        setScrollView()
        setUI()
        bind()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        MainTabViewModel.instance.bcObserver.accept(UIColor.rgb(red: 255, green: 245, blue: 230))
        let contentOffset = CGPoint(x: 0, y: 0)
        homeScrollView.setContentOffset(contentOffset, animated: true)
        homeSegmentedControl.setIndex(0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}

extension HomeViewController {
    
    private func setUI() {
        view.backgroundColor = .white
        safeArea.addSubview(homeScrollView)
        homeScrollView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.snp.top)
        }
        
        view.addSubview(homeSegmentedControl)
        homeSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top).offset(13)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(52)
        }
        
        view.addSubview(scrollToTopBt)
        scrollToTopBt.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-38)
        }
        
    }
    
    func bind() {
        
        scrollToTopBt.rx.tap.bind(to: chartVM.input.bottomBtObserver).disposed(by: disposedBag)
        
        homeSegmentedControl.addTarget(self, action: #selector(segonChnaged), for: .valueChanged)
        
        chartVM.output.getPost.drive(onNext: { value in
            let vm = PostDetailViewModel(value)
            let vc = PostDetailViewController(vm: vm)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }).disposed(by: disposedBag)
        
        chartVM.output.goError.drive(onNext: {
            let alertController = UIAlertController(title: "에러", message: "네트워크 연결상태를 확인해주세요.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alertController, animated: true)
        }).disposed(by: disposedBag)
        
        chartVM.output.goChartActionSheet.drive(onNext: {
            let vc = SortViewController()
            self.presentPanModal(vc)
            
        }).disposed(by: disposedBag)
        
        chartVM.output.goAllActionSheet.drive(onNext: {
            let vc = SortViewController()
            self.presentPanModal(vc)
        }).disposed(by: disposedBag)
        
        chartVM.output.getBottomAlpha.drive(onNext: {value in
            
            if value {
                self.scrollToTopBt.alpha = 1
            } else {
                self.scrollToTopBt.alpha = 0
            }
            
        }).disposed(by: disposedBag)
        
        
        
    }
    
    private func setScrollView() {
        let homeView:[UIView] = [HomeChartView(), HomeCalendarView(), HomeAllPostView()]
        homeScrollView.frame = UIScreen.main.bounds
        homeScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 3, height:UIScreen.main.bounds.height)
        for i in 0..<homeView.count {
            let xPos = self.view.frame.width * CGFloat(i)
            homeView[i].frame = CGRect(x: xPos, y: 0, width: homeScrollView.bounds.width, height: homeScrollView.bounds.height)
            
            homeScrollView.addSubview(homeView[i])
            homeScrollView.contentSize.width = homeView[i].frame.width * CGFloat(i + 1)
        }
    }
    
    @objc func segonChnaged(_ sender: BetterSegmentedControl) {
        switch sender.index {
        case 0:
            let contentOffset = CGPoint(x: 0, y: 0)
            homeScrollView.setContentOffset(contentOffset, animated: true)
            MainTabViewModel.instance.bcObserver.accept(UIColor.rgb(red: 255, green: 245, blue: 230))
        case 1:
            let contentOffset = CGPoint(x: view.frame.width, y: 0)
            homeScrollView.setContentOffset(contentOffset, animated: true)
            MainTabViewModel.instance.bcObserver.accept(.white)
        case 2:
            let contentOffset = CGPoint(x: view.frame.width * 2, y: 0)
            homeScrollView.setContentOffset(contentOffset, animated: true)
            MainTabViewModel.instance.bcObserver.accept(.white)
            goToAllView = true
        default:
            return
        }
    }
    
}

