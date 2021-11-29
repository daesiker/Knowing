//
//  BookMarkViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/20.
//

import UIKit
import Foundation
import Then
import RxCocoa
import RxSwift
import SwipeCellKit

class BookMarkViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let searchBar = CustomTextField(image: UIImage(named: "search")!, text: "검색", state: .search)
    var defaultOptions = SwipeOptions()
    var buttonStyle: ButtonStyle = .circular
    
    let countLb = UILabel().then {
        $0.text = "총 68건"
        $0.textColor = UIColor.rgb(red: 171, green: 171, blue: 171)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
    }
    
    let sortTitle = UILabel().then {
        $0.text = "높은 금액순"
        $0.textColor = UIColor.rgb(red: 210, green: 132, blue: 81)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
    }
    
    let sortBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "filterImg")!, for: .normal)
    }
    
    let bookmarkCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let bookmarkData = Observable<[String]>.of(["", "", "", "", "", ""])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCV()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
}

extension BookMarkViewController {
    
    func setUI() {
        view.backgroundColor = .white
        
        safeArea.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(44)
        }
        
        safeArea.addSubview(countLb)
        countLb.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(20)
        }
        
        safeArea.addSubview(sortBt)
        sortBt.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().offset(-12)
        }
        
        safeArea.addSubview(sortTitle)
        sortTitle.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(26)
            $0.trailing.equalTo(sortBt.snp.leading).offset(-6)
        }
        
        safeArea.addSubview(bookmarkCV)
        bookmarkCV.snp.makeConstraints {
            $0.top.equalTo(countLb.snp.bottom).offset(17)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    
    func setCV() {
        bookmarkCV.dataSource = nil
        bookmarkCV.delegate = nil
        bookmarkCV.register(PostCell.self, forCellWithReuseIdentifier: "cellId")
        bookmarkCV.rx.setDelegate(self).disposed(by: disposeBag)
        
        bookmarkData
            .bind(to: bookmarkCV.rx.items(cellIdentifier: "cellId", cellType: PostCell.self)) { row, element, cell in
                cell.contentView.layer.cornerRadius = 30
                cell.contentView.backgroundColor = UIColor.rgb(red: 255, green: 246, blue: 232)
                cell.delegate = self
            }.disposed(by: disposeBag)
        
    }
    
}


extension BookMarkViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 40
        return CGSize(width: width, height: 133)
    }
    
}

extension BookMarkViewController: SwipeCollectionViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let delete = SwipeAction(style: .default, title: "삭제") { action, indexPath in
            print("swife")
        }
        
        delete.backgroundColor = UIColor.rgb(red: 255, green: 152, blue: 87)
        delete.image = UIImage(named: "trash")!
        delete.accessibilityContainerType = .none
        
        delete.transitionDelegate = ScaleTransition.default
       
        return [delete]
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        
        options.buttonSpacing = 7
        
        
        return options
    }
    
    
}
