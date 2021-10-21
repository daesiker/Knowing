//
//  HomeViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/20.
//

import UIKit
import Foundation
import Then
import FSPagerView

protocol HomeMenuBarDelegate: AnyObject {
    func homeMenuBar(scrollTo index: Int)
}

class HomeViewController: UIViewController /*HomeMenuBarDelegate*/ {
    
    let homePageControll = FSPageControl()
    let homePageView = FSPagerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    
    
//    var pageCollectionView: UICollectionView = {
//        let collectionViewLayout = UICollectionViewFlowLayout()
//        collectionViewLayout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: collectionViewLayout)
//        collectionView.backgroundColor = .gray
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.isPagingEnabled = true
//        return collectionView
//    }()
//
//    var homeMenuBar = HomeMenuBar()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        navigationController?.hidesBarsOnSwipe = true
//        setHomeTabBar()
//        setPageCollectionView()
//    }
//
//    func setHomeTabBar() {
//        view.addSubview(homeMenuBar)
//        homeMenuBar.delegate = self
//        homeMenuBar.snp.makeConstraints {
//            $0.top.leading.trailing.equalToSuperview()
//            $0.height.equalToSuperview().multipliedBy(0.1)
//        }
//    }
//
//    func setPageCollectionView() {
//        pageCollectionView.delegate = self
//        pageCollectionView.dataSource = self
//        pageCollectionView.register(PageCell.self, forCellWithReuseIdentifier: PageCell.reuseIdentifier)
//        view.addSubview(pageCollectionView)
//        pageCollectionView.snp.makeConstraints {
//            $0.top.equalTo(homeMenuBar.snp.bottom)
//            $0.leading.trailing.bottom.equalToSuperview()
//        }
//    }
//
//    func homeMenuBar(scrollTo index: Int) {
//        let indexPath = IndexPath(row: index, section: 0)
//        self.pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//    }
    
}

//extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell.reuseIdentifier, for: indexPath) as! PageCell
//            cell.label.text = "\(indexPath.row + 1)번째 뷰"
//            return cell
//        }
//
//        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            return 3
//        }
//
////        func scrollViewDidScroll(_ scrollView: UIScrollView) {
////            homeMenuBar.indicatorViewLeadingConstraint.constant = scrollView.contentOffset.x / 3
////        }
//
//        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//            let itemAt = Int(targetContentOffset.pointee.x / self.view.frame.width)
//            let indexPath = IndexPath(item: itemAt, section: 0)
//            homeMenuBar.homeTabBarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
//        }
//}
//
//extension HomeViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: pageCollectionView.frame.width, height: pageCollectionView.frame.height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}
//
//class HomeViewHeaderCell: UICollectionViewCell {
//    static let reuseIdentifier = "homeHeaderCell"
//
//    let titleLabel = UILabel().then {
//        $0.text = ""
//        $0.textAlignment = .center
//        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        $0.textColor = .lightGray
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(titleLabel)
//        titleLabel.snp.makeConstraints {
//            $0.centerX.centerY.equalToSuperview()
//        }
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override var isSelected: Bool {
//        willSet {
//            if newValue {
//                titleLabel.textColor =  .black
//            } else {
//                titleLabel.textColor = .lightGray
//            }
//        }
//    }
//
//    override func prepareForReuse() {
//        isSelected = false
//    }
//
//
//}
//
//class HomeMenuBar: UIView {
//
//    weak var delegate: HomeMenuBarDelegate?
//
//    var homeTabBarCollectionView: UICollectionView = {
//        let collectionViewLayout = UICollectionViewFlowLayout()
//        collectionViewLayout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: collectionViewLayout)
//        collectionView.backgroundColor = .black
//        return collectionView
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
//
//extension HomeMenuBar: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewHeaderCell.reuseIdentifier, for: indexPath) as! HomeViewHeaderCell
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.frame.width / 3, height: 55)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.homeMenuBar(scrollTo: indexPath.row)
//        guard let cell = collectionView.cellForItem(at: indexPath) as? HomeViewHeaderCell else { return }
//        cell.titleLabel.textColor = .lightGray
//    }
//
//}
//
//extension HomeMenuBar: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}
//
//
//class PageCell: UICollectionViewCell {
//    static let reuseIdentifier = "homePageCell"
//    var label = UILabel().then {
//        $0.textColor = .black
//        $0.textAlignment = .center
//        $0.font = UIFont.systemFont(ofSize: 40, weight: .bold)
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .gray
//        addSubview(label)
//        label.snp.makeConstraints {
//            $0.centerX.centerY.equalToSuperview()
//        }
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
