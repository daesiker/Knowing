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

class HomeViewController: UIViewController  {
    
    var disposedBag = DisposeBag()
    
    let homeScrollView = UIScrollView().then {
        
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.alwaysBounceVertical = false
        $0.isScrollEnabled = false
        $0.bounces = false
    }
    
    let homeSegmentedControl: UISegmentedControl = {
        let segmentedArray:[String] = ["맞춤 복지", "나의 캘린더", "모든 복지"]
        let sc = UISegmentedControl(items: segmentedArray)
        //sc.addTarget(self, action: #selector(segonChnaged), for: UIControl.Event.valueChanged)
        sc.tintColor = UIColor.mainColor
        sc.selectedSegmentIndex = 0
        sc.sendActions(for: .valueChanged)
        return sc
    }()
    
//    @objc func segonChnaged(segcon: UISegmentedControl) {
//        switch segcon.selectedSegmentIndex {
//        case 0:
//            let contentOffset = CGPoint(x: 0, y: 0)
//            homeScrollView.setContentOffset(contentOffset, animated: true)
//        case 1:
//            let contentOffset = CGPoint(x: view.frame.width, y: 0)
//            homeScrollView.setContentOffset(contentOffset, animated: true)
//        case 2:
//            let contentOffset = CGPoint(x: view.frame.width * 2, y: 0)
//            homeScrollView.setContentOffset(contentOffset, animated: true)
//        default:
//            return
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollView()
        setUI()
        setBind()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        safeArea.addSubview(homeScrollView)
        homeScrollView.snp.makeConstraints {
            $0.edges.equalTo(self.view.snp.edges)
        }
        
        view.addSubview(homeSegmentedControl)
        homeSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func setBind() {
        homeSegmentedControl.rx.selectedSegmentIndex
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {value in
                switch value {
                case 0:
                    let contentOffset = CGPoint(x: 0, y: 0)
                    self.homeScrollView.setContentOffset(contentOffset, animated: true)
                case 1:
                    let contentOffset = CGPoint(x: self.view.frame.width, y: 0)
                    self.homeScrollView.setContentOffset(contentOffset, animated: true)
                case 2:
                    let contentOffset = CGPoint(x: self.view.frame.width * 2, y: 0)
                    self.homeScrollView.setContentOffset(contentOffset, animated: true)
                default:
                    return
                }
            }).disposed(by: disposedBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setScrollView() {
        let homeView:[UIView] = [HomeChartView(), HomeCalendarView(), HomeAllPostView()]
        homeScrollView.frame = UIScreen.main.bounds
        homeScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 3, height: UIScreen.main.bounds.height)
        for i in 0..<homeView.count {
            let xPos = self.view.frame.width * CGFloat(i)
            homeView[i].frame = CGRect(x: xPos, y: 0, width: homeScrollView.bounds.width, height: homeScrollView.bounds.height)
            homeScrollView.addSubview(homeView[i])
            homeScrollView.contentSize.width = homeView[i].frame.width * CGFloat(i + 1)
        }
    }
    
}
