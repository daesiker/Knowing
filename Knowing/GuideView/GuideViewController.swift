//
//  GuideViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/22.
//

import UIKit
import FSPagerView
import Then

class GuideViewController: UIViewController {

    let nextButton = CustomButton(title: "다음").then {
        $0.addTarget(self, action: #selector(goToNext), for: .touchUpInside)
    }
    
    let guideImages:[UIImage] = [UIImage(named: "guide1")!, UIImage(named: "guide2")!]
    
    let guidePagerView = FSPagerView().then {
        $0.transformer = FSPagerViewTransformer(type: .linear)
        $0.isInfinite = false
    }
    
    let guidePagerControl = FSPageControl().then {
        $0.setStrokeColor(.gray, for: .normal)
        $0.setStrokeColor(.orange, for: .selected)
        $0.setFillColor(.gray, for: .normal)
        $0.setFillColor(.orange, for: .selected)
    }
    
    @objc func goToNext(_ sender: UIButton) {
        if nextButton.titleLabel?.text == "다음" {
            guidePagerView.selectItem(at: 1, animated: true)
            nextButton.setTitle("시작하기", for: .normal)
        } else {
            let viewController = LoginViewController()
            let navController = UINavigationController(rootViewController: viewController)
            navController.isNavigationBarHidden = true
            navController.modalTransitionStyle = .crossDissolve
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPagerView()
        setUI()
    }
    
    func setUI() {
        view.addSubview(guidePagerView)
        guidePagerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        guidePagerView.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-30)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        guidePagerView.addSubview(guidePagerControl)
        guidePagerControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(nextButton.snp.top).offset(-50)
        }
    }
    
    func setPagerView() {
        guidePagerView.delegate = self
        guidePagerView.dataSource = self
        guidePagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        guidePagerControl.contentHorizontalAlignment = .leading
        guidePagerControl.numberOfPages = self.guideImages.count
    }

}


extension GuideViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return guideImages.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = guidePagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = guideImages[index]
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
        guidePagerView.deselectItem(at: index, animated: true)
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        self.guidePagerControl.currentPage = index
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        if targetIndex == 0 {
            nextButton.setTitle("다음", for: .normal)
        } else {
            nextButton.setTitle("시작하기", for: .normal)
        }
        self.guidePagerControl.currentPage = targetIndex
    }
    
}
